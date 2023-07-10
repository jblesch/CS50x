// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <strings.h>
#include <string.h>
#include <stdio.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

int wordcounter = 0;

// TODO: Choose number of buckets in hash table
const unsigned int N = 26;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    node *p;
    int index = hash(word);
    p = table[index];

    if (p == NULL)
    {
        return false;
    }
    while (p != NULL)
    {
        if (strcasecmp(word, p->word) == 0)
        {
            return true;
        }
        p = p -> next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    if (strlen(word) == 1)
    {
        return toupper(word[0]) - 'A';
    }
    else
    {
        return (toupper(word[0] + word[1])) - (2 * 'A');
    }
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO
    FILE *f = fopen(dictionary, "r");
    char *wordpull = malloc(sizeof(wordpull));
    if (f == NULL)
    {
        return false;
    }
    while (fscanf(f, "%s", wordpull) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }
        strcpy(n -> word, wordpull);
        int hashoutput = hash(wordpull);
        n -> next = table[hashoutput];
        table[hashoutput] = n;
        wordcounter += 1;
    }
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    if (wordcounter >= 1)
    {
        return wordcounter;
    }
    else
    {
        return 0;
    }
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    for (int i = 0; i < N; i++)
    {
        node *ptr = table[i];
        while (ptr != NULL)
        {
            node *next = ptr -> next;
            free(next);
            ptr = next;
        }
    }
    return true;
}
