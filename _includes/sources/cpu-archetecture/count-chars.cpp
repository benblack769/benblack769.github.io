#include <string>

using namespace std;

int count_chars(const string & s,char cmp){
    int count = 0;
    int str_size = s.size();
    for(int i = 0; i < str_size; i++){
        count += (s[i] == cmp);
    }
    return count;
}
