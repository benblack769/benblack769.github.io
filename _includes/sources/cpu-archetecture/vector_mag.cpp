#include <vector>
#include <cmath>
using namespace std;

float vector_norm(vector<float> & vec){
    int vec_size = vec.size();
    float sum = 0;
    for(int x = 0; x < vec_size; x++){
        float v = vec[x];
        sum += v*v;
    }
    return sqrt(sum);
}
