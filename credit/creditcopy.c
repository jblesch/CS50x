#include <cs50.h>
#include <stdio.h>

int coun_digits(long n);

int main(void)
{
    // Prompt the user for their card number
    long cardnumber;
    do
    {
        cardnumber = get_long("Number: \n");
    }
    while (cardnumber < 0);

    //Calculate the checksum
    long remainder;
    {
        remainder = (((cardnumber % 100)*2)+((cardnumber % 10000)*2)+((cardnumber % 1000000)*2)+
        ((cardnumber % 100000000)*2)+((cardnumber % 10000000000)*2)+((cardnumber % 1000000000000)*2)+
        ((cardnumber % 100000000000000)*2)+((cardnumber % 10000000000000000)*2))

        +((cardnumber % 10)+(cardnumber % 1000)+
        (cardnumber % 100000)+(cardnumber % 10000000)+(cardnumber % 1000000000)+(cardnumber % 100000000000)+
        (cardnumber % 10000000000000)+(cardnumber % 1000000000000000));
    }
        if (remainder % 10 == 0)
        {
            printf("VALID\n");
        }
        else
        {
            printf("INVALID\n");
        }
}