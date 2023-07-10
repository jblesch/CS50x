#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j].rgbtBlue = round(((image[i][j].rgbtBlue + image[i][j].rgbtRed + image[i][j].rgbtGreen) / 3.0));
            image[i][j].rgbtGreen = image[i][j].rgbtBlue;
            image[i][j].rgbtRed = image[i][j].rgbtGreen;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int originalred = image[i][j].rgbtRed;
            int originalgreen = image[i][j].rgbtGreen;
            int originalblue = image[i][j].rgbtBlue;
            if ((round((.393 * originalred) + (.769 * originalgreen) + (.189 * originalblue))) <= 255)
            {
                image[i][j].rgbtRed = round((.393 * originalred) + (.769 * originalgreen) + (.189 * originalblue));
            }
            else
            {
                image[i][j].rgbtRed = 255;
            }
            if (round((.349 * originalred) + (.686 * originalgreen) + (.168 * originalblue)) <= 255)
            {
                image[i][j].rgbtGreen = round((.349 * originalred) + (.686 * originalgreen) + (.168 * originalblue));
            }
            else
            {
                image[i][j].rgbtGreen = 255;
            }
            if ((round((.272 * originalred) + (.534 * originalgreen) + (.131 * originalblue))) <= 255)
            {
                image[i][j].rgbtBlue = round((.272 * originalred) + (.534 * originalgreen) + (.131 * originalblue));
            }
            else
            {
                image[i][j].rgbtBlue = 255;
            }
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0, n = ceil(width / 2); j < round(n); j++)
        {
            RGBTRIPLE temp;
            temp = image[i][j];
            image[i][j] = image[i][width - 1 - j];
            image[i][width - 1 - j] = temp;
        }
    }
    return;
}

// Blur image


void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float pixels_added = 0.0;
            int sumBlue = 0, sumGreen = 0, sumRed = 0;

            for (int k = -1; k < 2; k++)
            {
                if (i + k < 0 || i + k >= height)
                {
                    continue;
                }
                for (int l = -1; l < 2; l++)
                {
                    if (j + l < 0 || j + l >= width)
                    {
                        continue;
                    }
                    sumBlue += copy[i + k][j + l].rgbtBlue;
                    sumGreen += copy[i + k][j + l].rgbtGreen;
                    sumRed += copy[i + k][j + l].rgbtRed;
                    pixels_added++;
                }
            }
            image[i][j].rgbtBlue = round((sumBlue / pixels_added));
            image[i][j].rgbtGreen = round(sumGreen / pixels_added);
            image[i][j].rgbtRed = round((sumRed / pixels_added));
        }
    }
    return;
}