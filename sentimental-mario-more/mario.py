# import get_int from CS50 lib
from cs50 import get_int

# prompt the user for input of height
height = get_int("Height: ")
while height > 8 or height < 1:
    height = get_int("Height: ")

# print out the double pyramid of size height
counter = 1
while height > 0:
    print((height - 1)*" "+counter * "#"+"  "+counter * "#")
    counter += 1
    height -= 1

