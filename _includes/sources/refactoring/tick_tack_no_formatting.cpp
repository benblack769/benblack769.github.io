#include <iostream>
#include <windows.h>
#include <stdio.h>
#include <conio.h>
#include <cstdlib>
#include <ctime>

using namespace std;
    COORD coord = {0,0};
void place(int entry, char playchoice)
{int x, y;
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



int main()
{
srand(time(0));
char play;
    while (play != 'N'){
    int x = 3,y = 10, entry, t = 0, box1 = 0,box2 = 0,box3 = 0,box4 = 0,box5 = 0,box6 = 0,box7 = 0,box8 = 0,box9 = 0;
    int num1, num2, num3,num4,num5,num6,num7,num8;
        int i = 0, n;
    char playchoice;

    cout << "Tick Tack Toe\n\n";
    cout << "Do you want to be X (first players) or O (second player)?";
    cin >> playchoice;
    cout << "Enter numbers 1-9(as shown) to play \n";
    cout << "1 | 2 | 3\n";
    cout << "---------\n";
    cout << "4 | 5 | 6\n";
    cout << "---------\n";
    cout << "7 | 8 | 9\n\n";
    if (playchoice == 'X')
    cout << "You go first\n";
    else
    {
    cout << "Computer goes first\n";
    playchoice = 'O';
    }
    cout << "  |   |  \n";
    cout << "---------\n";
    cout << "  |   |  \n";
    cout << "---------\n";
    cout << "  |   |  \n";
    if (playchoice == 'X')
        n = 1;
    else
        n = 0;

while (t < 9)
{

    t = t + 1;
    i = (n + t) % 2;



if (i == 0){ /* Player move*/
    cin >> entry;

    if (entry == 1 and box1 == 0)
    {
        box1 = 1;
        place(1, playchoice);
    }
    else if (entry == 2 and box2 == 0)
    {
        box2 = 1;
        place(2, playchoice);
    }
    else if (entry == 3 and box3 == 0)
    {
        box3 = 1;
        place(3, playchoice);
    }
    else if (entry == 4 and box4 == 0)
    {
        box4 = 1;
        place(4, playchoice);
    }
    else if (entry == 5 and box5 == 0)
    {
         box5 = 1;
        place(5, playchoice);
    }
    else if (entry == 6 and box6 == 0)
    {
        box6 = 1;
        place(6, playchoice);
    }
    else if (entry == 7 and box7 == 0)
    {
        box7 = 1;
        place(7, playchoice);
    }
    else if (entry == 8 and box8 == 0)
    {
        box8 = 1;
        place(8, playchoice);
    }
    else if (entry == 9 and box9 == 0)
    {
        box9 = 1;
        place(9, playchoice);
    }
    else
    {cout << endl << "Please Enter a number from 1-9 that has not been taken";
    t = t - 2;
    }
    }
    else /* Computer move*/
    {
        if (playchoice == 'X')
            playchoice = 'O';
        else
            playchoice = 'X';

  /*first choice*/
            if (num1 == 20){
            place(1,playchoice);
            place(2,playchoice);
            place(3,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num2 == 20){
            place(4,playchoice);
            place(5,playchoice);
            place(6,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num3 == 20){
            place(7,playchoice);
            place(8,playchoice);
            place(9,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num4 == 20){
            place(1,playchoice);
            place(4,playchoice);
            place(7,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num5 == 20){
            place(2,playchoice);
            place(5,playchoice);
            place(8,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num6 == 20){
            place(3,playchoice);
            place(6,playchoice);
            place(9,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num7 == 20){
            place(1,playchoice);
            place(5,playchoice);
            place(9,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
            else if (num8 == 20){
            place(3,playchoice);
            place(5,playchoice);
            place(7,playchoice);
            cout << "\n\nComputer Wins!\n\n";
            break;
            }
        else if (box5 == 0){
            place(5,playchoice);
            box5 = 10;
            }
/*second choice*/else if ((num1 == 2 or num4 == 2 or num7 == 2) and box1 == 0){
            place(1,playchoice);
            box1 = 10;
            }
            else if ((num1 == 2 or num6 == 2 or num8 == 2) and box3 == 0){
                place(3,playchoice);
                box3 = 10;
            }
            /*box 5 is taken care of a the beginning of this code*/
            else if ((num3== 2 or num4 == 2 or num8 == 2) and box7 == 0){
                place(7,playchoice);
                box7 = 10;
            }
            else if ((num3 == 2 or num6 == 2 or num7 == 2) and box9 == 0){
                place(9,playchoice);
                box9 = 10;
            }
            else if ((num1 == 2 or num5 == 2) and box2 == 0){
                place(2,playchoice);
                box2 = 10;
            }
            else if ((num2 == 2 or num4 == 2) and box4 == 0){
                place(4,playchoice);
                box4 = 10;
            }
            else if ((num2 == 2 or num6 == 2) and box6 == 0){
                place(6,playchoice);
                box6 = 10;
            }
            else if ((num3 == 2 or num5 == 2) and box8 == 0){
                place(8,playchoice);
                box8 = 10;
            }
/*third choice*/else if ((num1 == 10 or num4 == 10 or num7 == 10) and box1 == 0){
            place(1,playchoice);
            box1 = 10;
            }
            else if ((num1 == 10 or num6 == 10 or num8 == 10) and box3 == 0){
                place(3,playchoice);
                box3 = 10;
            }
            /*box 5 is taken care of a the beginning of this code*/
            else if ((num3== 10 or num4 == 10 or num8 == 10) and box7 == 0){
                place(7,playchoice);
                box7 = 10;
            }
            else if ((num3 == 10 or num6 == 10 or num7 == 10) and box9 == 0){
                place(9,playchoice);
                box9 = 10;
            }
            else if ((num1 == 10 or num5 == 10) and box2 == 0){
                place(2,playchoice);
                box2 = 10;
            }
            else if ((num2 == 10 or num4 == 10) and box4 == 0){
                place(4,playchoice);
                box4 = 10;
            }
            else if ((num2 == 10 or num6 == 10) and box6 == 0){
                place(6,playchoice);
                box6 = 10;
            }
            else if ((num3 == 10 or num5 == 10) and box8 == 0){
                place(8,playchoice);
                box8 = 10;
            }
/*fourth choice*/else if (box1 == 0)
                    {
                        box1 = 10;
                        place(1,playchoice);
                    }
                    else if (box2 == 0)
                    {
                        box2 = 10;
                        place(2,playchoice);
                    }
                    else if (box3 == 0)
                    {
                        box3 = 10;
                        place(3,playchoice);
                    }
                    else if (box4 == 0)
                    {
                        box4 = 10;
                        place(4,playchoice);
                    }
                    else if (box5 == 0)
                    {
                        box5 = 10;
                        place(5,playchoice);
                    }
                    else if (box6 == 0)
                    {
                        box6 = 10;
                        place(6,playchoice);
                    }
                   else if (box7 == 0)
                    {
                        box7 = 10;
                        place(7,playchoice);
                    }
                    else if (box8 == 0)
                    {
                        box8 = 10;
                        place(8,playchoice);
                    }
                    else
                    {
                        box9 = 10;
                        place(9,playchoice);
                    }


        if (playchoice == 'O')
            playchoice = 'X';
        else
            playchoice = 'O';
    }

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
        cout << endl << endl;
        cout << "COMPUTER WINS!\n";
        break;
    }
    if (num1== 3 or num2 == 3 or num3 == 3 or num4 == 3 or num5 == 3 or num6 == 3 or num7 == 3 or num8 == 3)
    {
        cout << endl << endl;
        cout << "PLAYER WINS!";
        break;
    }
    cout << num1 << " " << num2 << " "<< num3 << " "<< num4 << " "<< num5 << " "<< num6 << " "<< num7 << " " << num8;

}
    if (t == 9)
    {
        cout << endl << endl;
        cout << "Draw.\n";
    }
    if (num1 == 30 or num2 == 30 or num3 == 30 or num4 == 30 or num5 == 30 or num6 == 30 or num7 == 30 or num8 == 30)
    {
        cout << endl << endl;
        cout << "COMPUTER WINS!\n";
    }
    if (num1== 3 or num2 == 3 or num3 == 3 or num4 == 3 or num5 == 3 or num6 == 3 or num7 == 3 or num8 == 3)
    {
        cout << endl << endl;
        cout << "PLAYER WINS!\n";
    }
    cout << "\n Do you want to play again (Y/N)";
    cin >> play;
    system("cls");
    }
    return 0;
}
