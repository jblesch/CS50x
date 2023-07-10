#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cs50.h>
#include <stdint.h>

#define BLOCK_SIZE 512

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Incorrect usage. \n");
        return 1;
    }

    // Open file
    FILE *file = fopen(argv[1], "r");

    // Check if file exists
    if (file == NULL)
    {
        printf("No such file found.\n");
        return 1;
    }

    int numbercounter = 0;
    char *filename = malloc(8 * sizeof(char));
    typedef uint8_t BYTE;
    BYTE buffer[BLOCK_SIZE];
    FILE *img = NULL;

    while (fread(&buffer, sizeof(BYTE), BLOCK_SIZE, file) == BLOCK_SIZE)
    {
        if (buffer[0] == 0xff && buffer [1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            if (numbercounter == 0)
            {
                sprintf(filename, "%03i.jpg", numbercounter);
                img = fopen(filename, "w");
                fwrite(buffer, 1, BLOCK_SIZE, img);
                numbercounter += 1;
            }
            else
            {
                fclose(img);
                sprintf(filename, "%03i.jpg", numbercounter);
                img = fopen(filename, "w");
                fwrite(buffer, 1, BLOCK_SIZE, img);
                numbercounter += 1;
            }
        }
        else if (numbercounter >= 1)
        {
            fwrite(buffer, 1, BLOCK_SIZE, img);
        }
    }
    fclose(img);
    fclose(file);
    free(filename);
}
