#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int letters_function(string input);
int words_function(string input);
int sentences_function(string input);


int main(void)
{
    // prompt the user for the input
    string input = get_string("Text: ");

    // call the functions for the local variables' output
    float letters = letters_function(input);
    float words = words_function(input);
    float sentence = sentences_function(input);
    float grade = ((0.0588 * (letters / words * 100)) - (0.296 * (sentence / words * 100))) - 15.8;

    if (grade >= 1 && grade < 16)
    {
        printf("Grade %i\n", (int) round(grade));
    }
    else if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade >= 16)
    {
        printf("Grade 16+\n");
    }
}

// count the letters in the text --> any charcter from a to z and A to Z

int letters_function(string input)
{
    int letters = 0;

    for (int i = 0, length = strlen(input); i < length; i++)
    {
        if (input[i] >= 'a' && input[i] <= 'z')
        {
            letters += 1;
        }
        else if (input[i] >= 'A' && input[i] <= 'Z')
        {
            letters += 1;
        }
    }
    return letters;
}

// count the words in the text --> any sequence of characters seperated by spaces, so count the spaces

int words_function(string input)
{
    int words = 1;

    for (int i = 0, length = strlen(input); i < length; i++)
    {
        if (input[i] == ' ')
        {
            words += 1;
        }
    }
    return words;
}

// count the sentences in the text --> any occurrence of a period etc. indicates the end of a sentence

int sentences_function(string input)
{
    int sentence = 0;

    for (int i = 0, length = strlen(input); i < length; i++)
    {
        if (input[i] == '.' || input [i] == '!' || input[i] == '?')
        {
            sentence += 1;
        }
    }
    return sentence;
}