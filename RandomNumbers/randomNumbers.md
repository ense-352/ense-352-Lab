## ENSE 352 - Fundamentals of Computer Systems Architectures - Laboratory

# Random Number Generation

### University of Regina
### Faculty of Engineering and Applied Science - Software Systems Engineering

### Lab Instructor: [Trevor Douglas](mailto:trevor.douglas@uregina.ca)

## Objective

The objective of this lab is to discuss random numbers and how it can help in the term project.


## Background
The Simon game requires blinking lights in a sequence and have the user replicate this by pressing the buttons in the same sequence.  This sequence should not be predictable between games or else the user will learn the pattern and outwit the game.

This means we need to generate a random number in order to create a random sequence.

### Rand
The ***rand()*** function that is part of the ***stdlib.h*** library will generate a ranodom number between 0 and RAND_MAX.  RAND_MAX is typically 2<sup>31</sup> -1 .  The ***rand()*** function is termed a pseudorandom number as it is predictable every time you run it.


<details>
<summary>expand rand.s</summary>

in `rand.s`

```C
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){
    printf("%d\n", rand());
    return 0;
}

```
</details>

### Seed
In order to not have a predictable pattern of random numbers you have to seed the generator using ***srand()***.  Now interesting enough you have to seed the generator with a different value every time you run your program or else ... you guessed it ... predictable.  So we need to come up with a way to seed the random number generator differently each time we run the program.

<details>
<summary>expand randomBetter.s</summary>

in `randomBetter.s`

```C
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char **argv){
    
    srand(time(0));
    for(int i=0; i <= 3; ++i)
	{

		printf("%d\n", rand());

	}
    return 0;
}

```
</details>

So ***time()*** will give us some different value every time we run.  Another solution to this problem, expecially if you are writing Assembly, is to utilize the opening sequence of our game to return some random value.  To do this, increment a value while waiting for the user to press a button.


### RAND_MAX
As mentioned RAND_MAX is between 0 and  2<sup>31</sup> -1 .  We only need a number between 0 and three.  One way to do this:

```C
int randomNumberTo4(void) {
   2     return rand() % 4 + 1;
   3 }

```
Since 4 does not divide equally into RAND_MAX it would favour certain numbers.  One way to solve this is to use a technique known as rejection sampling which will reject the extra remainder from the random range we want.

```C

#define NUMBER_OF_LEDS 4

/* return a uniform random value in the range 0..3 inclusive */
int randomNumberTo4()
{
    int limit;
    int r;

    limit = RAND_MAX - (RAND_MAX % NUMBER_OF_LEDS);

    while((r = rand()) >= limit);
 
    return r % NUMBER_OF_LEDS;
}

Reference -- https://www.cs.yale.edu/homes/aspnes/pinewiki/C(2f)Randomization.html