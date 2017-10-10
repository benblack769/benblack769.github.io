#include <string>

using namespace std;

int count_chars(const string & s,char cmp){
    int count = 0;
    for(char c : s){
        count += (c == cmp);
    }
    return count;
}
