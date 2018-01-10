#include <iostream>
#include <stdio.h>
#include <conio.h>
#include <cstdlib>
#include <ctime>
#include <cassert>

using namespace std;

char sqr_rep(char playerchoice, int box_num)
{
    switch (box_num) {
    case 0:
        return ' ';
    case 1:
        return 'X' == playerchoice ? 'X' : 'O';
    case 10:
        return 'X' == playerchoice ? 'O' : 'X';
    default:
        assert(false && "box_num not a valid quantity");
    }
}
void draw_board(char playchoice,int box[])
{
    cout << "Enter numbers 1-9(as shown) to play \n";
    cout << "1 | 2 | 3\n";
    cout << "---------\n";
    cout << "4 | 5 | 6\n";
    cout << "---------\n";
    cout << "7 | 8 | 9\n\n";
    if (playchoice == 'X')
        cout << "You go first\n";
    else
        cout << "Computer goes first\n";

    char pc = playchoice;
    cout << sqr_rep(pc, box[0]) << "|" << sqr_rep(pc, box[1]) << "|"
         << sqr_rep(pc, box[2]) << endl;
    cout << sqr_rep(pc, box[3]) << "|" << sqr_rep(pc, box[4]) << "|"
         << sqr_rep(pc, box[5]) << endl;
    cout << sqr_rep(pc, box[6]) << "|" << sqr_rep(pc, box[7]) << "|"
         << sqr_rep(pc, box[8]) << endl;
}
int main()
{
    srand(time(0));
    char play;
    while (play != 'N') {
        int x = 3, y = 10, entry, t = 0;
        int box[9] = {0};
        int num[8] = {-1};
        int i = 0, n;
        char playchoice;

        cout << "Tick Tack Toe\n\n";
        cout << "Do you want to be X (first players) or O (second player)?";
        cin >> playchoice;
        if (playchoice == 'X') {
            cout << "You go first\n";
        }
        else {
            cout << "Computer goes first\n";
            playchoice = 'O';
        }

        if (playchoice == 'X')
            n = 1;
        else
            n = 0;
        while (t < 9) {
            t = t + 1;
            i = (n + t) % 2;

            draw_board(playchoice, box);

            if (i == 0) { /* Player move*/
                cin >> entry;

                int box_num = entry - 1;
                if (box[box_num] == 0) {
                    box[box_num] = 1;
                }
                else {
                    cout << endl
                         << "Please Enter a number from 1-9 that has not been taken";
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
                if (num[0] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[1] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[2] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[3] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[4] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[5] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[6] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (num[7] == 20) {
                    cout << "\n\nComputer Wins!\n\n";
                    break;
                }
                else if (box[4] == 0) {
                    box[4] = 10;
                }
                /*second choice*/ else if ((num[0] == 2 or num[3] == 2 or num[6] == 2) and box[0] == 0) {
                    box[0] = 10;
                }
                else if ((num[0] == 2 or num[5] == 2 or num[7] == 2) and box[2] == 0) {
                    box[2] = 10;
                }
                /*box 5 is taken care of a the beginning of this code*/
                else if ((num[2] == 2 or num[3] == 2 or num[7] == 2) and box[6] == 0) {
                    box[6] = 10;
                }
                else if ((num[2] == 2 or num[5] == 2 or num[6] == 2) and box[8] == 0) {
                    box[8] = 10;
                }
                else if ((num[0] == 2 or num[4] == 2) and box[1] == 0) {
                    box[1] = 10;
                }
                else if ((num[1] == 2 or num[3] == 2) and box[3] == 0) {
                    box[3] = 10;
                }
                else if ((num[1] == 2 or num[5] == 2) and box[5] == 0) {
                    box[5] = 10;
                }
                else if ((num[2] == 2 or num[4] == 2) and box[7] == 0) {
                    box[7] = 10;
                }
                /*third choice*/ else if ((num[0] == 10 or num[3] == 10 or num[6] == 10) and box[0] == 0) {
                    box[0] = 10;
                }
                else if ((num[0] == 10 or num[5] == 10 or num[7] == 10) and box[2] == 0) {
                    box[2] = 10;
                }
                /*box 5 is taken care of a the beginning of this code*/
                else if ((num[2] == 10 or num[3] == 10 or num[7] == 10) and box[6] == 0) {
                    box[6] = 10;
                }
                else if ((num[2] == 10 or num[5] == 10 or num[6] == 10) and box[8] == 0) {
                    box[8] = 10;
                }
                else if ((num[0] == 10 or num[4] == 10) and box[1] == 0) {
                    box[1] = 10;
                }
                else if ((num[1] == 10 or num[3] == 10) and box[3] == 0) {
                    box[3] = 10;
                }
                else if ((num[1] == 10 or num[5] == 10) and box[5] == 0) {
                    box[5] = 10;
                }
                else if ((num[2] == 10 or num[4] == 10) and box[7] == 0) {
                    box[7] = 10;
                }
                /*fourth choice*/ else if (box[0] == 0) {
                    box[0] = 10;
                }
                else if (box[1] == 0) {
                    box[1] = 10;
                }
                else if (box[2] == 0) {
                    box[2] = 10;
                }
                else if (box[3] == 0) {
                    box[3] = 10;
                }
                else if (box[4] == 0) {
                    box[4] = 10;
                }
                else if (box[5] == 0) {
                    box[5] = 10;
                }
                else if (box[6] == 0) {
                    box[6] = 10;
                }
                else if (box[7] == 0) {
                    box[7] = 10;
                }
                else {
                    box[8] = 10;
                }

                if (playchoice == 'O')
                    playchoice = 'X';
                else
                    playchoice = 'O';
            }


            num[0] = box[0] + box[1] + box[2];
            num[1] = box[3] + box[4] + box[5];
            num[2] = box[6] + box[7] + box[8];
            num[3] = box[0] + box[3] + box[6];
            num[4] = box[1] + box[4] + box[7];
            num[5] = box[2] + box[5] + box[8];
            num[6] = box[0] + box[4] + box[8];
            num[7] = box[2] + box[4] + box[6];
            if (num[0] == 30 or num[1] == 30 or num[2] == 30 or num[3] == 30 or num[4] == 30 or num[5] == 30 or num[6] == 30 or num[7] == 30) {
                cout << endl
                     << endl;
                cout << "COMPUTER WINS!\n";
                break;
            }
            if (num[0] == 3 or num[1] == 3 or num[2] == 3 or num[3] == 3 or num[4] == 3 or num[5] == 3 or num[6] == 3 or num[7] == 3) {
                cout << endl
                     << endl;
                cout << "PLAYER WINS!";
                break;
            }
            cout << num[0] << " " << num[1] << " " << num[2] << " " << num[3] << " " << num[4]
                 << " " << num[5] << " " << num[6] << " " << num[7];
        }
        if (t == 9) {
            cout << endl
                 << endl;
            cout << "Draw.\n";
        }
        if (num[0] == 30 or num[1] == 30 or num[2] == 30 or num[3] == 30 or num[4] == 30 or num[5] == 30 or num[6] == 30 or num[7] == 30) {
            cout << endl
                 << endl;
            cout << "COMPUTER WINS!\n";
        }
        if (num[0] == 3 or num[1] == 3 or num[2] == 3 or num[3] == 3 or num[4] == 3 or num[5] == 3 or num[6] == 3 or num[7] == 3) {
            cout << endl
                 << endl;
            cout << "PLAYER WINS!\n";
        }
        cout << "\n Do you want to play again (Y/N)";
        cin >> play;
        //system("cls");
    }
    return 0;
}
