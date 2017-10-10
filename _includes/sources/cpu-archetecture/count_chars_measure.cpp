#include <iostream>
using namespace std;
#include "count-chars-fast.cpp"

constexpr int string_size = 10000;
constexpr int iters = 100000;

string gen_str(){
    string outstr(string_size,' ');
    for(int i = 0; i < string_size; i++){
        char c = 65+(i%25);
        outstr[i] = c;
    }
    return outstr;
}

int main(){
    string count = gen_str();
    int full_count = 0;
    for(int i = 0; i < iters; i++){
        full_count += count_chars(count,'D');
        count[i%string_size] += ((i%2)*2-1);
    }
    cout << full_count << endl;
}
