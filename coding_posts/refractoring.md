---
title: "Refactoring and reading"
slug: refractoring
under_construction: false
excerpt: "Walk through a difficult refractoring exercise."
---

My [Intuition and Structure](coding_posts/intuition-structure) page describes how to build decent code from scratch. However, what happens when you are given a awful codebase, and expected to do things with it quickly?

There are 2 obvious options:

1. Rewrite the code, then make the changes
2. Hack in the change to the existing code

I think the best way is to take the best parts of these two ideas by the following process:

1. Identify the structure of the current code
2. Identify the structure of the code you want to have
3. Make minimal movement towards the structure you want to have in order to make the change you want

## Tick Tack Toe example

Below is some code that allows you to play tick tack toe. I wrote it when I learned programming for the first time. In fact, it is the first code I was proud of. It is doing something kind of amazing, after all: perfectly executing a more or less optimal strategy (at least for the first player). It looks like this:

### Full code

<div style="height: 700px; overflow-y: auto;" >
{% highlight c++ linenos %}
{% include sources/refactoring/tick_tack_no_formatting.cpp%}
{% endhighlight %}
</div>

code also on a [github gist](https://gist.github.com/weepingwillowben/8786b84688936e206408d71ae040c18e).

Wow, this is super ugly. And there is an easy fix for this: automatic code formatters. The standard code formatter for c and c++ is called clang-format. If you don't feel like installing it, then [there is a website](http://format.krzaq.cc/) which allows you to use it.

Here is the formatted version. I am using the WebKit formatting, because it is closest to my own preferences.

<div style="height: 700px; overflow-y: auto;" >
{% highlight c++ linenos %}
{% include sources/refactoring/tick_tack.cpp%}
{% endhighlight %}
</div>

[link to code](/link_only/refractoring/full-code). You might want to open this up in another tab, as I'll be referencing line numbers, and you will want to look at it quite a bit.

Or [raw code](/link_only/refractoring/code-no-formatting) if you want to copy it into an editor.

### Process

Clearly, there are a bunch of problems with this code. But hopefully it looks complicated enough that you don't want to try to fix it all at once, which is why it makes a good example. I will walk you through the following steps of fixing this code:

1. Cross-Platform Support
2. Data structure cleanup
3. Testable logic
4. Structured AI

### Cross-Platform Support

The most serious problem here is the Windows specific code. I want my Mac and Linux friends to be able to use this too!

A quick scan through the code shows that there is only a few bits which uses the window.h API: the `SetConsoleCursorPosition` call on lines 26 and 36. There is also a system dependent `system("cls")` call on line 366. Lets look at the `SetConsoleCursorPosition` call first, as it is more complicated:

```c++
COORD coord = {0,0};
void place(int entry, char playchoice)
{
    int x, y;
    if (entry % 3 == 1)
        x = 0;
    if (entry % 3 == 2)
        x = 4;
    if (entry % 3 == 0)
        x = 8;

    if ((entry - 1) / 3 == 0)
        y = 11;
    else if ((entry - 1) / 3 == 1)
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

How on earth can we turn this mess into something cross-platform?  What is this mess? What is it accomplishing in this program?

Remember, the goal is to fix this quickly, and the easiest thing to do here is replace the `SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord)` call with a similar cross platform call.

After a quick search, the best I could find is [the solution to this question](http://www.cplusplus.com/forum/general/41709/). Copied here:

```c++
#ifdef _WIN32

#include <windows.h>

void gotoxy( int x, int y )
{
    COORD p = { x, y };
    SetConsoleCursorPosition( GetStdHandle( STD_OUTPUT_HANDLE ), p );
}

#else

//Make sure to link properly with the Unix version. You'll need to link with one of
//-lcurses
//-lterminfo
//-lncurses
//(whichever is appropriate for your system).
#include <unistd.h>
#include <term.h>

void gotoxy( int x, int y )
{
    int err;
    if (!cur_term)
      if (setupterm( NULL, STDOUT_FILENO, &err ) == ERR)
        return;
    putp( tparm( tigetstr( "cup" ), y, x, 0, 0, 0, 0, 0, 0, 0 ) );
}

#endif
```

Wow, this is ugly. And not only is it ugly, we still haven't finished making it truly portable, because it needs to link with different libraries depending on the Unix system. And if we are using some weird operating system, like a really old DOS OS, then even this code won't work.

So, if that is the best we can do to replace the specific API call with a cross-platform one, then I consider this a really poor solution. Lets try to find something better.

What can we do if we cannot make a call like that? Since the exact mechanics of the code cannot be matched, lets try to see what sort of functionality it creates, and see if we can implement that in a different way.

Here is the output of the program in a normal play through:

    Tick Tack Toe

    Do you want to be X (first players) or O (second player)?X
    Enter numbers 1-9(as shown) to play
    1 | 2 | 3
    ---------
    4 | 5 | 6
    ---------
    7 | 8 | 9

    You go first
    O | X | O
    ---------
      | X |
    ---------
      | O | X
    21 1 11 10 12 11 12 11

There are some odd things here, like the string of numbers below the second grid, which I have no idea why it is there, or even where in the code prints it out. But it is better than nothing, so for now, lets not worry about that at all, instead, lets focus on reproducing this general interface without the windows specific API.


The sane thing to do is to print out this whole thing using the game data. Preferably something that literally looks like this `print_game(game_data)`. So that is the structure we want to move to.

On the other hand, lets look try to decipher the structure of what it is actually doing. This is the hardest part, so I'll take it slowly this time.

If you [look back](/coding_posts/refractoring/#full-code) at the bits of code where the `place` function is being called, note that a `box#` variable is usually updated when place is called. For example, when user input is used on line 109-113:

```c++
else if (entry == 5 and box5 == 0) {
    box5 = 1;
    place(5, playchoice);
}
```

Now we need to make a few leaps of inference to figure out what is going on here. This is quite difficult, and does not come naturally (yes, for me too). What is important is too explore the code freely and to not be too afraid of being wrong. Just try it and see if it works!

Now I will just explore the code, and write down what I see.

Looking at the `box#` variables, it is being used to calculate the `num#` variables on line 326, which is used to calculate the strategy and who wins. Making a little leap of inference, the `box#` variables seem to be a significant portion of the game data, i.e., they are a part of the conceptual `game_data` structure.

Looking closer at the `place` function, the variables are talking about setting cursor position, and then it prints Xs or Os based on `playchoice`. Looking at the output, this tips me off that `place` is simply editing the screen to match the game data.

This is an abstraction of the pattern I keep on seeing:

    user-turn and computer-turn:
        input = make_choice(game_data)
        game_data = update_data(game_data, input)
        place(input)

I will call this a "dual update" structure, as there are two different locations of data, both of which are always updated when the state changes. Ideally, we will change this to a ordinary update structure, which has single source of truth, and fits nicely with our goal of creating a "pure output" structure.

Now, how do we achieve our goals of:

1. removing the windows specific functions
2. moving towards a better structure
3. not rewriting tons of code
4. not taking forever to achieve the above 3 goals

This quadruple standard is a little bit daunting, but the bottom 3 goals do not need to be met perfectly, it is perfectly fine to take a little bit too much time, or not really move to a great structure.

To meet the "don't rewrite code" requirement, lets go ahead and give ourselves a more specific requirement: don't change interface of the `place` function. It is being used in way too many places, any change to that will result in huge code changes.

To meet the goal of moving to a better structure, lets think about how our `draw_board(game_data)` function will work. It will probably take in the `#box` variables, which we identified as part of the `game_data`, and then print out the board, right?

Lets look at this conceptually for a bit. We will end up with something like this:

    user-turn and computer-turn:
        input = make_choice(game_data)
        game_data = update_data(game_data, input)
        place(input)

    draw_board(game_data)

But changing the board is what the `place` function is doing, right? So why do we need the `place` function if we have `draw_board`? The answer: we probably don't. Lets try running with that idea for awhile.

    user-turn and computer-turn:
        input = make_choice(data)
        update_data(input)

    draw_board(data)

Looking at this concept without place, we end up with a structure that doesn't really look all that diffrent from the ideal. So now , we can focus on implementing this.

Now, we can easily write draw_board like this:

```c++
//sqr_rep is a function that takes in the number frm the box, and outputs 'X', '_' or ' '
void draw_board(int box1, int box2, int box3, int box4, int box5, int box6, int box7, int box8, int box9){
    cout << sqr_rep(box1) << "|" << sqr_rep(box2) << "|" << sqr_rep(box3) << endl;
    cout << sqr_rep(box4) << "|" << sqr_rep(box5) << "|" << sqr_rep(box6) << endl;
    cout << sqr_rep(box7) << "|" << sqr_rep(box8) << "|" << sqr_rep(box9) << endl;
}
```

This is great, but we run into a little bit of a problem when trying to write `sqr_rep`. Note that the following does not quite work.

```c++
char sqr_rep(int box_num){
    switch(box_num){
        case 0: return ' ';
        case 1: return 'X';
        case 10: return 'O';
        default: assert(false && "box_num not a valid quantity");
    }
}
```

It sure seems to work. We know that 10 means computer, 1 means person, and 0 mean empty. But remember that we assigned X or O to the player or computer based on user input at the beginning of the game (stored in the `playerchoice` variable). This allows X to go first, whether it is the computer or the player, so that our game matches with common standards in tick tack toe.

Fixing this requires `sqr_rep` to know the `playerchoice` variable. Lets try rewriting `sqr_rep` to take this into account.

```c++
char sqr_rep(int box_num, char playerchoice){
    switch(box_num){
        case 0: return ' ';
        case 1: return 'X' == playerchoice ? 'X' : 'O';
        case 10: return 'X' == playerchoice ? 'O' : 'X';
        default: assert(false && "box_num not a valid quantity");
    }
}
```

and now we have to go back and rewrite  `draw_board`:

```c++
void draw_board(char playerchoice, int box1, int box2, int box3, int box4, int box5, int box6, int box7, int box8, int box9){
    char pc = playerchoice;
    cout << sqr_rep(box1,pc) << "|" << sqr_rep(box2,pc) << "|" << sqr_rep(box3,pc) << endl;
    cout << sqr_rep(box4,pc) << "|" << sqr_rep(box5,pc) << "|" << sqr_rep(box6,pc) << endl;
    cout << sqr_rep(box7,pc) << "|" << sqr_rep(box8,pc) << "|" << sqr_rep(box9,pc) << endl;
}
```

Now things are falling into place. We just need to fit everything in together (the hard part of implementation). The easiest way to do this is to simply try things until they work. This is not trivial, and can take a lot of time. If anything, it should take longer than the first part of identifying structure. But it is easier to brute force, and so it is basically the same process as debugging, so I'll just give you the finished code.

<div style="height: 700px; overflow-y: auto;" >
{% highlight c++ linenos %}
{% include sources/refactoring/windows_gone.cpp%}
{% endhighlight %}
</div>

[link to code](/link_only/refractoring/full-code) and  [link to raw code](/link_only/refractoring/code-no-formatting)


### Data-structure cleanup

####  Why we care about cleanup

Hopefully, when going through the previous section, you might have been frustrated at how hard the final step of fitting things together is. A traditional view of refactoring is simply changing the code to make future changes easier. This can make an incredible difference when making changes like the one above, the difference between pulling your hair out for hours vs. finishing the change in minutes. Cumulatively, this can be the difference between a successful project and an unsuccessful one.

I ignored this step in the first part partially to emphasize how important this is. For the next step, which will be testing the code, I will separate out the cleanup step from the testing step somewhat. This is a way of software development, but it is not always obvious when you want to do this cleanup. Many people do it too often, or too infrequently.

So I will try to also introduce you to some of the intuition about when to refractor things.

#### Importance of clean data structures

As I mentioned in my [post about structure](/coding_posts/intuition-structure), data structures are the most important thing to get right. Hopefully you can see how incredibly shitty the current data structures are, and start to see just how seriously they foil our attempts at making clear code. In the above argument, I kept on having to refer to `box#` variables instead of a single variable. There were all these cases made necessary by the fact that I had not method to programmatically access different box numbers (e.g., the 9 different cases for user input). Pretty much any more changes to the code (most critically adding testing) will be made far easier by cleaning up these data structures, so lets just get it over with now.

#### Identifying ideal data structures

First, lets identify what sort of data structures there should be.

It represents the 9 boxes as 9 separate variables, box[1-9]. The box is 1 if the player has it, 10 if the computer has it, and 0 if it is empty

### Testable logic

### Structured AI

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
