#include <vector>
#include <cmath>
using namespace std;

float vector_norm(vector<float> & vec){
    vector<float> intermed = vec;
    int vecsize = vec.size();
    for(int x = 0; x < vecsize; x++){
        intermed[x] = vec[x]*vec[x];
    }
    constexpr int unroll_size = 8;
    float sums[unroll_size] = {0};
    int x = 0;
    for(; x <= vecsize-unroll_size; x += unroll_size){
        for(int i = 0; i < unroll_size; i++){
            sums[i] += intermed[x+i];
        }
    }
    float tot_sum = 0;
    for(int i = 0; i < unroll_size; i++){
        tot_sum += sums[i];
    }
    for(; x < vecsize; x++){
        tot_sum += intermed[x];
    }
    return sqrt(tot_sum);
}
