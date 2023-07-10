#include <cs50.h>
#include <stdio.h>
#include <string.h>

const int BITS_IN_BYTE = 8;

void print_bulb(int bit);

int main(void)
{
    // ask for user input
    string word = get_string("Message: ");
}

void print_bulb(int bit)
{
    if (bit == 0)
    {
        // Dark emoji
        printf("\U000026AB");
    }
    else if (bit == 1)
    {
        // Light emoji
        printf("\U0001F7E1");
    }
}

int char

// string word needs to be conerted to chars

// each CHAR needs to be converted into a DEC

// each DEC needs to be converted into 8-bit BIN

// after each BYTE there needs to be a "next" line

// Ablauf: string word --> char characters --> int decimal for each CHAR --> int binary for each CHAR

// example for A: A is 65 in Decimal; to resemble in binary, we want to divide 65 with 2 as long there is no remainder
