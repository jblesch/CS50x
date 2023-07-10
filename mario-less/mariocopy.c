#include <cs50.h>
#include <stdio.h>

int main(void)

//ask the user for the height of the pyramid
{
    int height;

    do
    {
        height = get_int("Height: ");
    }
    while (height > 8 || height < 1);

//use the variable 'height' to print out the correct number of rows and correct number of hashes for the pyramid

    for (int row = 0; row + 1 < height; row++)
    {
            printf("#");
            printf("\n");
    for (int blocks = 0; blocks < row + 1; blocks++)

            printf("#");
    }
    printf("#\n");
}