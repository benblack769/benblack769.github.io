#include <string>

using namespace std;

int count_chars(const string & s,char cmp){
    int count = 0;
    constexpr int maxcount = 255;
    const int str_size = s.size();
    int i = 0;
    for(; i <= str_size-maxcount; i += maxcount){
        char inner_count = 0;
        for(int j = 0; j < maxcount; j++){
            inner_count += (s[i+j] == cmp);
        }
        count += inner_count;
    }
    for(; i < str_size; i += 1){
        count += (s[i] == cmp);
    }
    return count;
}
