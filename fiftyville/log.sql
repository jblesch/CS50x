Tables:

CREATE TABLE crime_scene_reports (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    street TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE interviews (
    id INTEGER,
    name TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    transcript TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE atm_transactions (
    id INTEGER,
    account_number INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    atm_location TEXT,
    transaction_type TEXT,
    amount INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE bank_accounts (
    account_number INTEGER,
    person_id INTEGER,
    creation_year INTEGER,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE airports (
    id INTEGER,
    abbreviation TEXT,
    full_name TEXT,
    city TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE flights (
    id INTEGER,
    origin_airport_id INTEGER,
    destination_airport_id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_airport_id) REFERENCES airports(id),
    FOREIGN KEY(destination_airport_id) REFERENCES airports(id)
);
CREATE TABLE passengers (
    flight_id INTEGER,
    passport_number INTEGER,
    seat TEXT,
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
CREATE TABLE phone_calls (
    id INTEGER,
    caller TEXT,
    receiver TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    duration INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE people (
    id INTEGER,
    name TEXT,
    phone_number TEXT,
    passport_number INTEGER,
    license_plate TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE bakery_security_logs (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    activity TEXT,
    license_plate TEXT,
    PRIMARY KEY(id)
);





Crime Scene Reports that are relevant (because of the date and street oft he theft):

| 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |

| 297 | 2021 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.





Interviews that are relevant (the crime scene reports hints at three interviewst hat all mention the bakery):

| 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
                                        The thief then asked the person on the other end of the phone to purchase the flight ticket.

| 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

| 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.


License Plates that are relevant (because of interview that states the thief leaving within ten minutes of the theft):

 id  | year | month | day | hour | minute | activity | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+    |
| 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
| 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
| 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
| 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
| 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
| 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |


Person Info on the license plates:
 id  | year | month | day | hour | minute | activity | license_plate |   id   |  name   |  phone_number  | passport_number | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+--------+---------+----------------+-----------------+---------------+
| 258 | 2021 | 7     | 28  | 10   | 8      | entrance | R3G7486       | 325548 | Brandon | (771) 555-6667 | 7874488539      | R3G7486       |
| 259 | 2021 | 7     | 28  | 10   | 14     | entrance | 13FNH73       | 745650 | Sophia  | (027) 555-1068 | 3642612721      | 13FNH73       |
| 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       | 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
| 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       | 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
| 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
| 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       | 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58


Flight Info (the thief wanted to take the earliest flight on the day after the robbery):
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 43 | 8                 | 1                      | 2021 | 7     | 29  | 9    | 30     |
| 23 | 8                 | 11                     | 2021 | 7     | 29  | 12   | 15     |
| 53 | 8                 | 9                      | 2021 | 7     | 29  | 15   | 20     |
| 18 | 8                 | 6                      | 2021 | 7     | 29  | 16   | 0      |


Destination of the thief(since he/she wanted to take the first flight out of fiftyville on the 29th):

| id | abbreviation |     full_name     |     city      |
+----+--------------+-------------------+---------------+
| 4  | LGA          | LaGuardia Airport | New York City


People who were on flight 36:
-- SELECT * FROM people JOIN passengers ON people.passport_number = passengers.passport_number JOIN flights ON passengers.flight_id = flights.id WHERE flights.id = 36;
+--------+--------+----------------+-----------------+---------------+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+
|   id   |  name  |  phone_number  | passport_number | license_plate | flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+--------+--------+----------------+-----------------+---------------+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+
| 953679 | Doris  | (066) 555-9701 | 7214083635      | M51FA04       | 36        | 7214083635      | 2A   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       | 36        | 1695452385      | 3B   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 36        | 5773159633      | 4A   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 651714 | Edward | (328) 555-1152 | 1540955065      | 130LD9Z       | 36        | 1540955065      | 5C   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       | 36        | 8294398571      | 6C   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | 36        | 1988161715      | 6D   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 395717 | Kenny  | (826) 555-1652 | 9878712108      | 30G67EN       | 36        | 9878712108      | 7A   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
| 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       | 36        | 8496433585      | 7B   | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20


Querschnitt, wer es sein könnte:
- Luca, Bruce, Sofia, Kelsey

People who withdrew money on the day of the theft:
qlite> SELECT * FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id JOIN atm_transactions ON bank_accounts. account_number = atm_transactions.account_number WHERE year = 2021 and month = 7 and day = 28 and atm_location = "Leggett Street";
|   id   |  name   |  phone_number  | passport_number | license_plate | account_number | person_id | creation_year | id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+--------+---------+----------------+-----------------+---------------+----------------+-----------+---------------+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 49610011       | 686048    | 2010          | 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 948985 | Kaelyn  | (098) 555-1164 | 8304650265      | I449449       | 86363979       | 948985    | 2010          | 275 | 86363979       | 2021 | 7     | 28  | Leggett Street | deposit          | 10     |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       | 26013199       | 514354    | 2012          | 336 | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     |
| 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       | 16153065       | 458378    | 2012          | 269 | 16153065       | 2021 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       | 28296815       | 395717    | 2014          | 264 | 28296815       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       | 25506511       | 396669    | 2014          | 288 | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       | 28500762       | 467400    | 2014          | 246 | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       | 76054385       | 449774    | 2015          | 266 | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     |
| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       | 81061156       | 438727    | 2018          | 313 | 81061156       | 2021 | 7     | 28  | Leggett Street | withdraw         | 30


Quertschnitt Nr. 2, wer es sein könnte:
- Luca / Bruce

Find out who used his phone on the day of the theft:
SELECT * FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE year = 2021 and month = 7 and day = 28;
+--------+-----------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+
|   id   |   name    |  phone_number  | passport_number | license_plate | id  |     caller     |    receiver    | year | month | day | duration |
+--------+-----------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+
| 650560 | Rose      | (336) 555-0077 | 8909375052      | O7JQ1SA       | 211 | (336) 555-0077 | (098) 555-1164 | 2021 | 7     | 28  | 318      |
| 331484 | Judy      | (918) 555-5327 | 1236213682      | KGG82IR       | 212 | (918) 555-5327 | (060) 555-2489 | 2021 | 7     | 28  | 146      |
| 757606 | Douglas   | (491) 555-2505 | 3231999695      | 1FW4EUJ       | 213 | (491) 555-2505 | (478) 555-1565 | 2021 | 7     | 28  | 241      |
| 567218 | Jack      | (996) 555-8899 | 9029462229      | 52R0Y8U       | 214 | (996) 555-8899 | (059) 555-4698 | 2021 | 7     | 28  | 142      |
| 652398 | Carl      | (704) 555-5790 | 7771405611      | 81MZ921       | 215 | (704) 555-5790 | (772) 555-5770 | 2021 | 7     | 28  | 200      |
| 518594 | Randy     | (984) 555-5921 | 7538263720      | 106OW2W       | 216 | (984) 555-5921 | (618) 555-9856 | 2021 | 7     | 28  | 546      |
| 837455 | Andrew    | (579) 555-5030 |                 | W2CT78U       | 217 | (579) 555-5030 | (971) 555-6468 | 2021 | 7     | 28  | 421      |
| 580086 | Betty     | (233) 555-0473 | 2400516856      | 47KK91C       | 218 | (233) 555-0473 | (831) 555-0973 | 2021 | 7     | 28  | 113      |
| 754943 | Nathan    | (293) 555-1469 | 8914039923      | 11WB3I6       | 219 | (293) 555-1469 | (749) 555-4874 | 2021 | 7     | 28  | 195      |
| 279793 | Cheryl    | (450) 555-8297 |                 | VWJ25E5       | 220 | (450) 555-8297 | (771) 555-7880 | 2021 | 7     | 28  | 298      |
| 398010 | Sofia     | (130) 555-0289 | 1695452385      | G412CB7       | 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
| 764823 | Keith     | (209) 555-7806 | 9698118788      | 630U2R7       | 222 | (209) 555-7806 | (693) 555-7986 | 2021 | 7     | 28  | 487      |
| 253397 | Kristina  | (918) 555-2946 | 6131360461      | P743G7C       | 223 | (918) 555-2946 | (006) 555-0505 | 2021 | 7     | 28  | 359      |
| 560886 | Kelsey    | (499) 555-9472 | 8294398571      | 0NTHK55       | 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
| 779942 | Harold    | (669) 555-6918 |                 | DVS39US       | 225 | (669) 555-6918 | (914) 555-5994 | 2021 | 7     | 28  | 233      |
| 274893 | Christina | (547) 555-8781 | 4322787338      | 79X5400       | 226 | (547) 555-8781 | (398) 555-1013 | 2021 | 7     | 28  | 272      |
| 358382 | Walter    | (544) 555-8087 | 4223654265      | 82456Y8       | 227 | (544) 555-8087 | (389) 555-5198 | 2021 | 7     | 28  | 595      |
| 280744 | Eugene    | (666) 555-5774 | 9584465633      | 47592FJ       | 228 | (666) 555-5774 | (125) 555-8030 | 2021 | 7     | 28  | 326      |
| 720244 | Dorothy   | (047) 555-0577 | 9135709773      | 7T807V5       | 229 | (047) 555-0577 | (059) 555-4698 | 2021 | 7     | 28  | 379      |
| 243696 | Barry     | (301) 555-4174 | 7526138472      | 6P58WS2       | 230 | (301) 555-4174 | (711) 555-3007 | 2021 | 7     | 28  | 583      |
| 372684 | Alexander | (801) 555-9266 |                 | 8P9NEU9       | 231 | (801) 555-9266 | (984) 555-5921 | 2021 | 7     | 28  | 148      |
| 750165 | Daniel    | (971) 555-6468 | 7597790505      | FLFN3W0       | 232 | (971) 555-6468 | (267) 555-2761 | 2021 | 7     | 28  | 149      |
| 686048 | Bruce     | (367) 555-5533 | 5773159633      | 94KL13X       | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
| 561160 | Kathryn   | (609) 555-5876 | 6121106406      | 4ZY7I8T       | 234 | (609) 555-5876 | (389) 555-5198 | 2021 | 7     | 28  | 60       |
| 572028 | Paul      | (357) 555-0246 | 9143726159      | R64E41W       | 235 | (357) 555-0246 | (502) 555-6712 | 2021 | 7     | 28  | 305      |
| 686048 | Bruce     | (367) 555-5533 | 5773159633      | 94KL13X       | 236 | (367) 555-5533 | (344) 555-9601 | 2021 | 7     | 28  | 120      |
| 585903 | Arthur    | (394) 555-3247 | 7884829354      | 64I1286       | 237 | (394) 555-3247 | (035) 555-2997 | 2021 | 7     | 28  | 111      |
| 506435 | Zachary   | (839) 555-1757 |                 | 5810O6V       | 238 | (839) 555-1757 | (487) 555-5865 | 2021 | 7     | 28  | 278      |
| 719061 | Ashley    | (770) 555-1196 | 1038053449      |               | 239 | (770) 555-1196 | (324) 555-0416 | 2021 | 7     | 28  | 527      |
| 718152 | Jason     | (636) 555-4198 | 2818150870      | 8666X39       | 240 | (636) 555-4198 | (670) 555-8598 | 2021 | 7     | 28  | 69       |
| 231387 | Margaret  | (068) 555-0183 | 1782675901      | 60563QT       | 241 | (068) 555-0183 | (770) 555-1861 | 2021 | 7     | 28  | 371      |
| 336397 | Joan      | (711) 555-3007 |                 | L476K20       | 242 | (711) 555-3007 | (113) 555-7544 | 2021 | 7     | 28  | 157      |
| 477251 | Billy     | (060) 555-2489 | 9290922261      | 2HB7G9N       | 243 | (060) 555-2489 | (204) 555-4136 | 2021 | 7     | 28  | 510      |
| 484375 | Anna      | (704) 555-2131 |                 |               | 244 | (704) 555-2131 | (891) 555-5672 | 2021 | 7     | 28  | 103      |
| 686048 | Bruce     | (367) 555-5533 | 5773159633      | 94KL13X       | 245 | (367) 555-5533 | (022) 555-4052 | 2021 | 7     | 28  | 241      |
| 850016 | Mark      | (873) 555-3868 | 4631067354      | YD7376W       | 246 | (873) 555-3868 | (047) 555-0577 | 2021 | 7     | 28  | 109      |
| 225259 | Sean      | (867) 555-9103 | 4377966420      |               | 247 | (867) 555-9103 | (068) 555-0183 | 2021 | 7     | 28  | 116      |
| 337221 | Christine | (608) 555-9302 |                 | XE95071       | 248 | (608) 555-9302 | (725) 555-3243 | 2021 | 7     | 28  | 280      |
| 293753 | Ryan      | (901) 555-8732 |                 | 0WZS77X       | 249 | (901) 555-8732 | (491) 555-2505 | 2021 | 7     | 28  | 451      |
| 255860 | Virginia  | (478) 555-1565 | 3866596772      |               | 250 | (478) 555-1565 | (717) 555-1342 | 2021 | 7     | 28  | 573      |
| 560886 | Kelsey    | (499) 555-9472 | 8294398571      | 0NTHK55       | 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
| 505688 | Jean      | (695) 555-0348 | 1682575122      | JN7K44M       | 252 | (695) 555-0348 | (338) 555-6650 | 2021 | 7     | 28  | 383      |
| 600585 | Bryan     | (696) 555-9195 | 3833243751      | 8911U63       | 253 | (696) 555-9195 | (258) 555-5627 | 2021 | 7     | 28  | 525      |
| 449774 | Taylor    | (286) 555-6063 | 1988161715      | 1106N58       | 254 | (286) 555-6063 | (676) 555-6554 | 2021 | 7     | 28  | 43       |
| 514354 | Diana     | (770) 555-1861 | 3592750733      | 322W7JE       | 255 | (770) 555-1861 | (725) 555-3243 | 2021 | 7     | 28  | 49       |
| 336397 | Joan      | (711) 555-3007 |                 | L476K20       | 256 | (711) 555-3007 | (147) 555-6818 | 2021 | 7     | 28  | 358      |
| 221103 | Vanessa   | (725) 555-4692 | 2963008352      | 5P2BI95       | 257 | (725) 555-4692 | (821) 555-5262 | 2021 | 7     | 28  | 456      |
| 559765 | William   | (324) 555-0416 |                 | FA63H32       | 258 | (324) 555-0416 | (452) 555-8550 | 2021 | 7     | 28  | 328      |
| 360948 | Carolyn   | (234) 555-1294 | 3925120216      | P14PE2Q       | 259 | (234) 555-1294 | (772) 555-5770 | 2021 | 7     | 28  | 573      |
| 779942 | Harold    | (669) 555-6918 |                 | DVS39US       | 260 | (669) 555-6918 | (971) 555-6468 | 2021 | 7     | 28  | 67       |
| 907148 | Carina    | (031) 555-6622 | 9628244268      | Q12B3Z3       | 261 | (031) 555-6622 | (910) 555-3251 | 2021 | 7     | 28  | 38       |
| 821978 | Beverly   | (342) 555-9260 | 2793107431      |               | 262 | (342) 555-9260 | (219) 555-0139 | 2021 | 7     | 28  | 404      |
| 821978 | Beverly   | (342) 555-9260 | 2793107431      |               | 263 | (342) 555-9260 | (487) 555-5865 | 2021 | 7     | 28  | 560      |
| 372684 | Alexander | (801) 555-9266 |                 | 8P9NEU9       | 264 | (801) 555-9266 | (608) 555-9302 | 2021 | 7     | 28  | 425      |
| 658630 | Brittany  | (398) 555-1013 |                 | 6T124Q8       | 265 | (398) 555-1013 | (329) 555-5870 | 2021 | 7     | 28  | 237      |
| 677698 | John      | (016) 555-9166 | 8174538026      | 4468KVT       | 266 | (016) 555-9166 | (336) 555-0077 | 2021 | 7     | 28  | 88       |
| 818095 | Patricia  | (594) 555-2863 | 5806941094      | R059OD5       | 267 | (594) 555-2863 | (491) 555-2505 | 2021 | 7     | 28  | 361      |
| 458378 | Brooke    | (122) 555-4581 | 4408372428      | QX4YZN3       | 268 | (122) 555-4581 | (831) 555-0973 | 2021 | 7     | 28  | 491      |
| 809265 | Jose      | (914) 555-5994 | 9183348466      |               | 269 | (914) 555-5994 | (973) 555-3809 | 2021 | 7     | 28  | 320      |
| 534459 | Olivia    | (258) 555-5627 | 6632213958      | X273ZK9       | 270 | (258) 555-5627 | (695) 555-0348 | 2021 | 7     | 28  | 368      |
| 620297 | Peter     | (751) 555-6567 | 9224308981      | N507616       | 271 | (751) 555-6567 | (594) 555-6254 | 2021 | 7     | 28  | 61       |
| 604497 | Ralph     | (771) 555-7880 | 6464352048      | 3933NUH       | 272 | (771) 555-7880 | (711) 555-3007 | 2021 | 7     | 28  | 288      |
| 975354 | Logan     | (219) 555-0139 | 9692634019      | 6866W0M       | 273 | (219) 555-0139 | (867) 555-9103 | 2021 | 7     | 28  | 514      |
| 250277 | James     | (676) 555-6554 | 2438825627      | Q13SVG6       | 274 | (676) 555-6554 | (328) 555-9658 | 2021 | 7     | 28  | 153      |
| 242207 | Louis     | (749) 555-4874 | 5361280978      |               | 275 | (749) 555-4874 | (492) 555-5484 | 2021 | 7     | 28  | 575      |
| 210245 | Jordan    | (328) 555-9658 | 7951366683      | HW0488P       | 276 | (328) 555-9658 | (775) 555-7584 | 2021 | 7     | 28  | 579      |
| 975354 | Logan     | (219) 555-0139 | 9692634019      | 6866W0M       | 277 | (219) 555-0139 | (910) 555-3251 | 2021 | 7     | 28  | 121      |
| 591369 | Dylan     | (380) 555-4380 | 5776544886      | DN6Z7FH       | 278 | (380) 555-4380 | (680) 555-4935 | 2021 | 7     | 28  | 550      |
| 395717 | Kenny     | (826) 555-1652 | 9878712108      | 30G67EN       | 279 | (826) 555-1652 | (066) 555-9701 | 2021 | 7     | 28  | 55       |
| 682850 | Ethan     | (594) 555-6254 | 2996517496      | NAW9653       | 280 | (594) 555-6254 | (123) 555-5144 | 2021 | 7     | 28  | 346      |
| 438727 | Benista   | (338) 555-6650 | 9586786673      | 8X428L0       | 281 | (338) 555-6650 | (704) 555-2131 | 2021 | 7     | 28  | 54       |
| 750165 | Daniel    | (971) 555-6468 | 7597790505      | FLFN3W0       | 282 | (971) 555-6468 | (258) 555-5627 | 2021 | 7     | 28  | 441      |
| 717401 | Terry     | (730) 555-5115 | 3564659888      | 5209A97       | 283 | (730) 555-5115 | (343) 555-0167 | 2021 | 7     | 28  | 101      |
| 449774 | Taylor    | (286) 555-6063 | 1988161715      | 1106N58       | 284 | (286) 555-6063 | (310) 555-8568 | 2021 | 7     | 28  | 235      |
| 686048 | Bruce     | (367) 555-5533 | 5773159633      | 94KL13X       | 285 | (367) 555-5533 | (704) 555-5790 | 2021 | 7     | 28  | 75       |
| 419774 | Teresa    | (041) 555-4011 | 8699553201      | HW0BF87       | 286 | (041) 555-4011 | (609) 555-5876 | 2021 | 7     | 28  | 565      |
| 255860 | Virginia  | (478) 555-1565 | 3866596772      |               | 287 | (478) 555-1565 | (031) 555-6622 | 2021 | 7     | 28  | 398


Wer ist enthalten von Bruce und Luca?
sqlite> SELECT * FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE year = 2021 and month = 7 and day = 28 and name = "Bruce" or "Luca"
|   id   | name  |  phone_number  | passport_number | license_plate | id  |     caller     |    receiver    | year | month | day | duration |
+--------+-------+----------------+-----------------+---------------+-----+----------------+----------------+------+-------+-----+----------+
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 245 | (367) 555-5533 | (022) 555-4052 | 2021 | 7     | 28  | 241      |
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 236 | (367) 555-5533 | (344) 555-9601 | 2021 | 7     | 28  | 120      |
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 285 | (367) 555-5533 | (704) 555-5790 | 2021 | 7     | 28  | 75


wen hat er alles angerufen (unter 1 Minute?)
SELECT * FROM people WHERE phone_number = "(375) 555-8161";
 id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 864400 | Robin | (375) 555-8161 |                 | 4V16VO0 