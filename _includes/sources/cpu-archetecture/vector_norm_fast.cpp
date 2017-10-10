#include <vector>
#include <cmath>
using namespace std;

float vector_norm(vector<float> & vec){
    vector<float> intermed = vec;
    int vecsize = vec.size();
    for(int x = 0; x < vecsize; x++){
        intermed[x] = vec[x]*vec[x];
    }
    float sum = 0;
    for(int x = 0; x < vecsize; x++){
        sum += intermed[x];
    }
    return sqrt(sum);
}
