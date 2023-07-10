# TODO
import re
from cs50 import get_int
from cs50 import get_string


def main():
    number = get_string("Number: ")
    length = len(number)

    if check_sum(number) == True:
        if length == 16 and number[0] == '4' or length == 13 and number[0] == '4':
            print("VISA")
        elif length == 16 and number[0] == '5' and number[1] == '1' or length == 16 and number[0] == '5' and number[1] == '2' or length == 16 and number[0] == '5' and number[1] == '3' or length == 16 and number[0] == '5' and number[1] == '4' or length == 16 and number[0] == '5' and number[1] == '5':
            print("MASTERCARD")
        elif length == 15 and number[0] == '3' and number[1] == '4' or number[1] == '7':
            print("AMEX")
        else:
            print("INVALID")
    else:
        print("INVALID")


def check_sum(number):
    sum = 0
    for i in range(-2, -(len(number) + 1), -2):
        tmp = int(number[i]) * 2
        sum += (tmp // 10) + (tmp % 10)
    for k in range(-1, -(len(number) + 1), -2):
        sum += int(number[k])
    if (sum % 10 == 0):
        return True
    else:
        return False


if __name__ == "__main__":
    main()