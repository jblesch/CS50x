# Couples' Vacation Planner
#### Video Demo:  <URL https://youtu.be/aFRO_xogOAo>
#### Description:

**Introduction**


Hi,

my name is Jochen from Munich, Germany.

My CS 50 final project is called 'Couples' Vacation Planner'. It is a web app that is supposed to help keep track and manage a couples' annual leave.
The basic idea is that by working with 3 tables in a database, the web-app helps you plan and display all planned vacations. The overview shows you how many days you and your partner have left to plan on in the respective year.

The web-app has 7 distinct routes.: Register, Login, Index, Master Data, Plan, Overview, and Apology.

**The routes**

The registering route allows everybody to create an account by choosing a username and a password. If the user types in a username which is not already used (by parsing through a table 'users' in the project.db) and checking if the password is the same (two inputs of the same password), the user is created and 'inserted' to the 'users' table; before that the password is hashed and stored as such in the 'users' table. If the user omits any needed information or a username is already in use, the user is redirected to the 'apology' route where he/she is prompted with the respective fault (e.g. please choose different username).

Afterwards the user is able to log in via the 'login' route. There, the username and password are searched for in the SQL database (in the 'users' table). If the information (username and hashed password) match, the user is logged in and the user information is stored inside the variable 'session', which is used in the function 'login-required' which is pre-requisite for all html routes to work properly.

The index page shows an introduction of the final project and what the web-app is supposed to do. It also features an image of Dante's View  in Death Valley, CA which is a link to the Kayak.com webpage to search for flights (as an easteregg) and includes an inspirational quote by Anthony Bourdain.

The master data route includes a form where you can enter the needed basic data of you and your friend or partner: year (on which you want to work on), names, annual leave (days you have available from your employer), and unused vacation days from the previous year.
Once entered, the data is stored in a table called 'master' in the project.db databank. The data is used in the overview and the plan page (e.g. the user names are plugged into the plan form).

Once you have entered the masterdata you are re-directed to the overview page. If you have not used or entered any vacation plans you will need to go to the route: 'plan' to enter your vacation plans. This route cointains a form with various inputs: vacation (name or destination of your planned vacation), proposal (what you want to do there), start-date, end-date, the necessary vacation days for each person (one person might need more than the other) and the employer status for each person (not proposed yet, proposed, approved). All this information is stored in the SQL table 'plan' in the project.db databank.

After submitting the plan, you are redirected to the overview route where you can now display the overview you want to look at by selecting the respective year. The overview now shows a table with all the information you gave the web-app. It shows a summary of how many days you have left to freely plan on in the respective year and it shows (sorted) all vacations that are planned. On the 'overview' page you can also remove vacations that you need to cancel for example. This form is pre-populated only with the vacations of the respective year, you are working on.

In this way, the Couples' Vacation planner tries to simplify the management of vacations of two friends or a couple.






