# TODO
from cs50 import get_string


def main():
    string = get_string("Text: ")

    sum_chars = 0
    sum_words = 1
    sum_sente = 0

    for i in range(len(string)):
        if string[i].isalpha():
            sum_chars += 1
        if string[i] == ' ':
            sum_words += 1
        if string[i] == "?" or string[i] == "." or string[i] == "!":
            sum_sente += 1

    L = sum_chars / sum_words * 100
    S = sum_sente / sum_words * 100
    grade = 0.0588 * L - 0.296 * S - 15.8

    if grade < 1:
        print("Before Grade 1")
    if grade >= 16:
        print("Grade 16+")
    else:
        print(f"Grade {int(round(grade))}")


if __name__ == "__main__":
    main()
