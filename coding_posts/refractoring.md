---
title: "Refactoring and reading"
---

My Intuition and Structure page describes how to build decent code from scratch. However, what happens when you are given a awful codebase, and expected to do things with it quickly?

There are 2 obvious options:

1. Rewrite the code, then make the changes
2. Hack in the change to the existing code

I think the best way is to take the best parts of these two ideas by the following process:

1. Identify the structure of the current code
2. Identify the structure of the code you want to have
3. Make minimal movement towards the structure you want to have in order to make the change you want

## Tick Tack Toe example



Below is some code that allows you to play tick tack toe. I wrote only a few weeks from when I learned programming for the first time. It represents the 9 boxes as 9 separate variables, box[1-9]. The box is 1 if the player has it, 10 if the computer has it, and 0 if it is empty. It then finds out who won (full code [here](https://gist.github.com/weepingwillowben/8786b84688936e206408d71ae040c18e), windows only unfortunately). It looks like this:

### Full code
<style>
.gist-data > div > div > table {
    height: 1000px;
    overflow-y: auto;
}
</style>

{% gist 8786b84688936e206408d71ae040c18e %}

### Process

Cleary, there are a bunch of problems with this code. But hopefully it looks complicated enough that you don't want to try to fix it all at once. I will walk you through the following steps of fixing this code:

1. Cross-Platform Support
2. Data structure cleanup
3. Testable logic
4. Structured AI

### Cross-Platform Support

The most serious problem here is the windows specific code. I want my Apple friends to be able to use this too!

A quick scan through the code shows that there is only one bit which uses the windows specific API. Lets look at it:

```c++
COORD coord = {0,0};
void place(int entry, char playchoice)
{
    int x, y;
       if(entry % 3 == 1)
        x = 0;
       if (entry % 3 == 2)
        x = 4;
       if (entry % 3 == 0)
        x = 8;

       if ((entry - 1) / 3 == 0)
        y = 11;
       else if ((entry - 1) /3 == 1)
        y = 13;
       if ((entry - 1) / 3 == 2)
        y = 15;
    COORD coord;
    coord.X = x;
    coord.Y = y;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
if (playchoice == 'X')
cout << "X";
else
cout << "O";

    coord.X = 0;
    coord.Y = 16;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);

}
```

Nicely for us, it is

Here is a relatively simple problem which should demonstrate this. The problem is that I know how to check if someone won in tick tack toe. Simple enough, right? You check the rows, columns, and diagonals, and see if a player occupies all the spots there. But this problem, and other similar to it haunted me for years afterwards, making my code error prone, and difficult to debug.



```c++
    num1 = box1 + box2 + box3;
    num2 = box4 + box5 + box6;
    num3 = box7 + box8 + box9;
    num4 = box1 + box4 + box7;
    num5 = box2 + box5 + box8;
    num6 = box3 + box6 + box9;
    num7 = box1 + box5 + box9;
    num8 = box3 + box5 + box7;
    if (num1 == 30 or num2 == 30 or num3 == 30 or num4 == 30 or num5 == 30 or num6 == 30 or num7 == 30 or num8 == 30)
    {
        cout << "COMPUTER WINS!\n";
        break;
    }
    if (num1 == 3 or num2 == 3 or num3 == 3 or num4 == 3 or num5 == 3 or num6 == 3 or num7 == 3 or num8 == 3)
    {
        cout << "PLAYER WINS!";
        break;
    }
```

As you can see, I could code a solution with the tools I had at hand. And at the time, that was enough. But now, I realize that it is not very good. It has lots and lots of variables and arbitrary constants, which makes checking/debugging the code hard and slow. It is just about impossible to generalize to larger grids. Understandable for my first code, but lets try to do better.

The standard approach would be to iteratively refractor this, until it looks decent. We would put the numbered variables in an array, then loop over them, in some places, take out functions, etc, to make the code more concise and stuff. This is not a bad approach. But it can actually be harder than building it up again from scratch, and it is easier to make poor choices. So instead, lets try to think of things structurally, picking out what each part of the code really accomplishes, and build this up.

First, basic data structures. What is a tick tack toe board anyways? It is a grid that looks like this, right?

    X|O|S
    X|O|_
    O|X|O

We really only care about the rows, columns, and diagonals. If you trace your finger over the rows, columns and diagonals, you might notice that your finger seems to be moving quite freely over a 2 dimensional discrete space. This reveals that the base data structure needs two qualities, it needs to store discrete values. Luckily, there is already a standard solution to general discrete 2d movement, the 2d array.

    board = array[3][3];

Now, how do we represent the Xs, Os, and blanks? Again, think of what we they actually are, and what we need of them. They actually are symbols that represent something about the game. We need them to be distinct from each other, and to not allow for anything other than Xs, Os, and blanks. Here there are several options. Strongly typed enums have these qualities. But perhaps this is overkill, as they also have other guarantees, such as efficient use as a key, which we don't need. So lets make our own type that meets these conditions.



Ok, so that wraps up the data structure. Now we need to look at the tasks we ask of that data. These can be thought of as queries, or manipulations.

Here is a task. We want the user of the software to be able to choose a coordinate, and then set that to be the players symbol if it is not already chosen. If it is already chosen, then we want to change nothing, and tell the user that they need to choose something else.

Wow, that is a lot of requirements. And it is the thing that experienced coders can just crank out without thinking about it at all. So

Here is a more complicated task, the original one.

Lets take
