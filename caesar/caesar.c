#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <stdlib.h>


bool only_digits(string k);
char rotate(char input, int key);

int main(int argc, string argv[])
{
    // Make sure program is run with just one command-line argument
    if (argc != 2 || only_digits(argv[1]) == false)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
    // Prompt user for plaintext
    string plaintext = get_string("plaintext:  ");

    // Convert argv [1] from a 'string' to an 'int'
    int key = atoi(argv[1]);

    printf("ciphertext: ");

    for (int i = 0, length = strlen(plaintext); i < length; i++)
    {
        printf("%c", (rotate(plaintext[i], key)));
    }
    printf("\n");
    return 0;
}


bool only_digits(string k)
{
    int n = 0;
    for (int i = 0, length = strlen(k); i < length; i++)
    {
        if (isdigit(k[i]))
        {
            n++;
        }
    }
    // Make sure argv[1] is a positive integer
    if (n > 0 && n == strlen(k))
    {
        return true;
    }
    else
    {
        return false;
    }
}

//For each character in the plaintext:
// Rotate the character if it's a letter
char rotate(char input, int k)
{
    if (isupper(input))
    {
        input = (((input - 65) + k) % 26) + 65;
        return input;
    }
    if (islower(input))
    {
        input = (((input - 97) + k) % 26) + 97;
        return input;
    }
    if (isspace(input))
    {
        return input;
    }
    if (isdigit(input))
    {
        return input;
    }
    if (!isalnum(input))
    {
        return input;
    }
    return 1;
}













