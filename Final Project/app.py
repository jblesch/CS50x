from cs50 import SQL
from flask import Flask, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
from helpers import apology, login_required

# start up application
app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

db = SQL("sqlite:///project.db")

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
    if request.method  == "GET":
        return render_template("index.html")

@app.route("/plan", methods=["GET", "POST"])
@login_required
def plan():
    if request.method == "GET":
        name1 = db.execute("SELECT name1 FROM master WHERE user_id = ?;", session['user_id'])
        name2 = db.execute("SELECT name2 FROM master WHERE user_id = ?;", session['user_id'])
        if all (not d for d in name1):
            name1='User 1'
        else:
            name1= [d['name1'] for d in name1][0]
        if all (not d for d in name2):
            name2='User 2'
        else:
            name2= [d['name2'] for d in name2][0]
        return render_template("plan.html", name1=name1, name2=name2)

    elif request.method == "POST":
        vacation = request.form.get("vacation")
        proposal = request.form.get("proposal")
        start_date = request.form.get("start_date")
        end_date = request.form.get("end_date")
        status1 = request.form.get("status1")
        status2 = request.form.get("status2")
        days_used1 = request.form.get("days_used1")
        days_used2 = request.form.get("days_used2")
        if not vacation or not proposal or not start_date or not end_date or not status1 or not status2 or not days_used1 or not days_used2:
            return apology("please fill in all necessary data")
        else:
            db.execute("INSERT INTO plan (vacation, proposal, start_date, end_date, status1, status2, days_used1, days_used2, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);", vacation, proposal, start_date, end_date, status1, status2, days_used1, days_used2, session["user_id"])
    return redirect("/overview")


@app.route("/overview", methods=["GET", "POST"])
@login_required
def overview():
    if request.method == "GET":
        name1 = db.execute("SELECT name1 FROM master WHERE user_id = ?;", session['user_id'])
        name2 = db.execute("SELECT name2 FROM master WHERE user_id = ?;", session['user_id'])
        if all (not d for d in name1):
            name1='User 1'
        else:
            name1= [d['name1'] for d in name1][0]
        if all (not d for d in name2):
            name2='User 2'
        else:
            name2= [d['name2'] for d in name2][0]
        return render_template("overview.html", name1=name1, name2=name2)

    elif request.method == "POST":
        if 'anno' in request.form:
            anno = request.form.get("anno")
            year = anno + '%'
            table = db.execute("SELECT * FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
            delete = db.execute("SELECT vacation FROM plan WHERE user_id = ? and end_date LIKE ?;", session['user_id'], year)
            vacation_days1 = db.execute("SELECT vacation_days1 + vacation_days_left_last_year1 FROM master WHERE user_id = ? and vacation_year = ?;", session["user_id"], anno)
            vacation_days2 = db.execute("SELECT vacation_days2 + vacation_days_left_last_year2 FROM master WHERE user_id = ? and vacation_year = ?;", session["user_id"], anno)
            name1 = db.execute("SELECT name1 FROM master WHERE user_id = ?;", session['user_id'])
            name2 = db.execute("SELECT name2 FROM master WHERE user_id = ?;", session['user_id'])
            if all (not d for d in name1):
                name1='User 1'
            else:
                name1= [d['name1'] for d in name1][0]
            if all (not d for d in name2):
                name2='User 2'
            else:
                name2= [d['name2'] for d in name2][0]
            if all (not d for d in vacation_days1):
                vacation_days1 = 0
                if all (not d for d in vacation_days2):
                    vacation_days2 = 0
                    days_used_total1 = db.execute("SELECT COALESCE(SUM(days_used1), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total2 = db.execute("SELECT COALESCE(SUM(days_used2), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total1 = [d['COALESCE(SUM(days_used1), 0)'] for d in days_used_total1][0]
                    days_used_total2 = [d['COALESCE(SUM(days_used2), 0)'] for d in days_used_total2][0]
                    days_left1 = vacation_days1 - days_used_total1
                    days_left2 = vacation_days2 - days_used_total2
                    return render_template("overview.html", table=table, vacation_days1=vacation_days1, days_left1=days_left1, vacation_days2=vacation_days2, days_left2=days_left2, delete=delete, name1=name1, name2=name2)
                else:
                    days_used_total1 = db.execute("SELECT COALESCE(SUM(days_used1), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total2 = db.execute("SELECT COALESCE(SUM(days_used2), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total1 = [d['COALESCE(SUM(days_used1), 0)'] for d in days_used_total1][0]
                    days_used_total2 = [d['COALESCE(SUM(days_used2), 0)'] for d in days_used_total2][0]
                    days_left1 = vacation_days1 - days_used_total1
                    days_left2 = vacation_days2 - days_used_total2
                    return render_template("overview.html", table=table, vacation_days1=vacation_days1, days_left1=days_left1, vacation_days2=vacation_days2, days_left2=days_left2, delete=delete, name1=name1, name2=name2)

            else:
                vacation_days1 = [d['vacation_days1 + vacation_days_left_last_year1'] for d in vacation_days1][0]
                if all (not d for d in vacation_days2):
                    vacation_days2 = 0
                    days_used_total1 = db.execute("SELECT COALESCE(SUM(days_used1), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total2 = db.execute("SELECT COALESCE(SUM(days_used2), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total1 = [d['COALESCE(SUM(days_used1), 0)'] for d in days_used_total1][0]
                    days_used_total2 = [d['COALESCE(SUM(days_used2), 0)'] for d in days_used_total2][0]
                    days_left1 = vacation_days1 - days_used_total1
                    days_left2 = vacation_days2 - days_used_total2
                    return render_template("overview.html", table=table, vacation_days1=vacation_days1, days_left1=days_left1, vacation_days2=vacation_days2, days_left2=days_left2, delete=delete, name1=name1, name2=name2)
                else:
                    vacation_days2 = [d['vacation_days2 + vacation_days_left_last_year2'] for d in vacation_days2][0]
                    days_used_total1 = db.execute("SELECT COALESCE(SUM(days_used1), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total2 = db.execute("SELECT COALESCE(SUM(days_used2), 0) FROM plan WHERE user_id = ? and end_date LIKE ?;", session["user_id"], year)
                    days_used_total1 = [d['COALESCE(SUM(days_used1), 0)'] for d in days_used_total1][0]
                    days_used_total2 = [d['COALESCE(SUM(days_used2), 0)'] for d in days_used_total2][0]
                    days_left1 = vacation_days1 - days_used_total1
                    days_left2 = vacation_days2 - days_used_total2
                    return render_template("overview.html", table=table, vacation_days1=vacation_days1, days_left1=days_left1, vacation_days2=vacation_days2, days_left2=days_left2, delete=delete, name1=name1, name2=name2)

        elif 'remove' in request.form:
            vacation_removed = request.form.get("delete")
            delete = db.execute("SELECT vacation FROM plan WHERE user_id = ?;", session['user_id'])
            db.execute("DELETE FROM plan WHERE vacation = ? and  user_id = ?;", vacation_removed, session["user_id"])
            name1 = db.execute("SELECT name1 FROM master WHERE user_id = ?;", session['user_id'])
            name2 = db.execute("SELECT name2 FROM master WHERE user_id = ?;", session['user_id'])
            if all (not d for d in name1):
                name1='User 1'
            else:
                name1= [d['name1'] for d in name1][0]
            if all (not d for d in name2):
                name2='User 2'
            else:
                name2= [d['name2'] for d in name2][0]
            return render_template("overview.html", name1=name1, name2=name2)


@app.route("/master", methods=["GET", "POST"])
@login_required
def master():
    if request.method == "GET":
        return render_template("master.html")

    elif request.method == "POST":
            print(request.form)
            if 'submit' in request.form:
                vacation_year = request.form.get("year")
                name1 = request.form.get("name1")
                name2 = request.form.get("name2")
                vacation_days1 = request.form.get("vacation_days1")
                vacation_days2 = request.form.get("vacation_days2")
                vacation_days_left_last_year1 = request.form.get("vacation_days_last_year1")
                vacation_days_left_last_year2 = request.form.get("vacation_days_last_year2")
                if not vacation_year or not name1 or not name2 or not vacation_days1 or not vacation_days2 or not vacation_days_left_last_year1 or not vacation_days_left_last_year2:
                    return apology("please fill out all data")
                else:
                    db.execute("DELETE FROM master WHERE vacation_year = ? and user_id = ?;", vacation_year, session['user_id'])
                    db.execute("INSERT INTO master (vacation_year, name1, name2, vacation_days1, vacation_days2, vacation_days_left_last_year1, vacation_days_left_last_year2, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?);",
                           vacation_year, name1, name2, vacation_days1, vacation_days2, vacation_days_left_last_year1, vacation_days_left_last_year2, session["user_id"])
                    return redirect("/overview")

            elif 'reset' in request.form:
                db.execute("DELETE FROM master WHERE user_id = ?;", session["user_id"])
                return redirect("overview")


@app.route("/login", methods=["GET", "POST"])
def login():

    # clear all session data
    session.clear()

    if request.method == "POST":

        # check if username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # check if password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # store the usersdatabase in a list of dicts
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

    # clear session data
    session.clear()

    # Redirect user to login form
    return redirect("/")



@app.route("/register", methods=["GET", "POST"])
def register():
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


