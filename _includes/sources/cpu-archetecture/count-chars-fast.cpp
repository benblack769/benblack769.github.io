#include <string>

using namespace std;

int count_chars(const string & s,char cmp){
    int count = 0;
    constexpr int maxcount = 255;
    int i = 0;
    for(; i <= s.size()-maxcount; i += maxcount){
        char inner_count = 0;
        for(int j = 0; j < maxcount; j++){
            inner_count += (c == cmp);
        }
        count += inner_count;
    }
    for(; i < s.size(); i += 1){
        count += (c == cmp);
    }
    return count;
}
