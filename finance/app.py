import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash
from datetime import datetime
from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/", methods=["GET", "POST"])
@login_required
def index():
    """Show portfolio of stocks"""
    user_id = session["user_id"]
# access the buy database to show symbol and shares
    rows = db.execute("SELECT symbol, SUM(shares) FROM buy WHERE user_id = :user_id GROUP BY symbol", user_id=session["user_id"])
    cash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
# access and printing the cash in USD
    cash = [d['cash'] for d in cash][0]
 # calculating the current price of the stock and return the value and grand totaol
    arrprice = []
    arrtotal = []
    for row in rows:
        symbol = row['symbol']
        shares = row['SUM(shares)']
        price = lookup(symbol)
        cprice = price['price']
        total = (shares * cprice)
        arrprice.append(cprice)
        arrtotal.append(total)
    gtotal = (cash) + sum(arrtotal)
    usdprice = list(map(usd, arrprice))
    usdtotal = list(map(usd, arrtotal))

    return render_template("index.html", database=rows, cash=usd(cash), usdprice=usdprice, usdtotal=usdtotal, gtotal=usd(gtotal))


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "GET":
        return render_template("buy.html")
    elif request.method == "POST":
        symbol = request.form.get("symbol")
        if not symbol:
            return apology("please choose a stock")
        symbol = lookup(symbol.upper())
        if not symbol:
            return apology("there is no such stock")
        shares = request.form.get("shares")
        if shares.isnumeric() == False:
            return apology("share must be number")
        shares = int(shares)
        if shares < 1:
            return apology("please choose a positive number of shares!")
        else:
            price = symbol['price']
            cash = db.execute("SELECT cash FROM users WHERE id = :id;", id=session["user_id"])
            cash = [d['cash'] for d in cash]
            cash = cash[0]
            symbol = request.form.get("symbol")
            if (shares * price) > cash:
                return apology("insufficient funds")
            else:
                # calculate cash used
                cashused = shares * price
                cash = cash - cashused
                date = datetime.now()
                symbol = symbol.upper()
                # create new table with the following fields: userid = int (primary); shares = float; symbol = text; price = float; cash(after purchase) = float; date = text; foreign key = id (users)
                # CREATE TABLE buy (buy_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, shares REAL, symbol TEXT NOT NULL, price REAL, date TEXT, user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users(id));
                # document the buy in a new table and subtract the cash used from the users cash
                price = usd(price)
                db.execute("INSERT INTO buy (shares, symbol, price, date, user_id) VALUES (?, ?, ?, ?, ?);",
                           shares, symbol, price, date, session["user_id"])
                db.execute("UPDATE users SET cash = ? WHERE id = ?", cash, session["user_id"])
                # rows = db.execute("INSERT INTO users ( ) VALUES (?,?);", )
                category = 'buy'
                db.execute("INSERT INTO history (category, symbol, shares, price, datetime, user_id) VALUES (?, ?, ?, ?, ?, ?);",
                           category, symbol, shares, price, date, session["user_id"])
                return redirect("/")


@app.route("/history", methods=["GET"])
@login_required
def history():
    """Show history of transactions"""
    database = db.execute("SELECT * FROM history;")
    return render_template("history.html", database=database)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "POST":
        query = request.form.get("symbol")
        if not query:
            return apology("please type in a valid symbol", 400)
        quote = lookup(query.upper())
        if not quote:
            return apology("no such stock available", 400)
        else:
            return render_template("quoted.html", name=quote['name'], symbol=quote['symbol'], price=usd(quote['price']))
    else:
        return render_template("quote.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "POST":

        usernames_list = []
        for rows in db.execute("SELECT * FROM users"):
            usernames_list.append(rows['username'])

        username = request.form.get("username")
        if not username:
            return apology("please type in a username", 400)
        if username in usernames_list:
            return apology("please choose other username")

        password = request.form.get("password")
        confirmation = request.form.get("confirmation")
        if not password:
            return apology("please choose a password")
        if not confirmation:
            return apology("please confirm password")
        if password == confirmation:
            password = generate_password_hash(password)
            rows = db.execute("INSERT INTO users (username, hash) VALUES (?,?);", username, password)
            return render_template("login.html")
        else:
            return apology("please check your passwords")

    elif request.method == "GET":
        return render_template("register.html")


@app.route("/money", methods=["GET", "POST"])
@login_required
def money():
    """Insert more cash"""
    if request.method == "GET":
        return render_template("money.html")
    elif request.method == "POST":
        cash_insert = request.form.get("money")
        cash = db.execute("SELECT cash FROM users WHERE id = :id;", id=session["user_id"])
        cash = [d['cash'] for d in cash][0]
        cash_insert = int(cash_insert)
        cashtotal = cash + cash_insert
        db.execute("UPDATE users SET cash = ? WHERE id = ?", cashtotal, session["user_id"])
    return redirect("/")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "GET":
        return render_template("sell.html")

    elif request.method == "POST":
        shares = request.form.get("shares")
        if shares.isnumeric() == False:
            return apology("share must be a positive integer")
        shares = int(shares)
        if shares < 1:
            return apology("please choose a positive number of shares!")
        symbol = request.form.get("symbol")
        if not symbol:
            return apology("you need to type in a symbol")
        symbol = lookup(symbol.upper())
        if not symbol:
            return apology("there is no such stock")
        else:
            symbol_user = db.execute("SELECT symbol FROM buy WHERE user_id = :user_id;", user_id=session["user_id"])
            symbol = request.form.get("symbol")
            symbol = symbol.upper()
            print(symbol_user)
            print(symbol)
            if not any(d['symbol'] == symbol for d in symbol_user):
                return apology("stock not in portfolio")
            shares_user = db.execute("SELECT SUM(shares) FROM buy WHERE symbol = :symbol", symbol=symbol)
            shares_user = [d['SUM(shares)'] for d in shares_user][0]
            if shares > shares_user:
                return apology("you do not have sufficient stock to sell")
            else:
                symbol = lookup(symbol.upper())
                price = symbol['price']
                totalsell = shares * price
                cash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
                cash = [d['cash'] for d in cash][0]
                cash += totalsell
                db.execute("UPDATE users SET cash = ? WHERE id = ?", cash, session["user_id"])
                shares_left = shares_user - shares
                price = symbol['price']
                symbol = request.form.get("symbol").upper()
                db.execute("DELETE FROM buy WHERE shares = 0")
                db.execute("UPDATE buy SET shares = ? WHERE user_id = ? AND symbol = ?", shares_left, session["user_id"], symbol)
                db.execute("DELETE FROM buy WHERE shares = 0")
                category = 'sell'
                date = datetime.now()
                price = usd(price)
                db.execute("INSERT INTO history (category, symbol, shares, price, datetime, user_id) VALUES (?, ?, ?, ?, ?, ?);",
                           category, symbol, shares, price, date, session["user_id"])
        return redirect("/"
                        )