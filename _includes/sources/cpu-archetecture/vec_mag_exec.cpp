#include <vector>
#include <iostream>
#include "vector_norm_fast.cpp"

using namespace std;

int main(){
    int size = 1000;
    int iters = 1000000;
    vector<float> vals(size,1.0);
    float v = 0;
    for(int i = 0; i < iters;i++){
        v += vector_norm(vals);
        vals[int(v)%size] += 0.001;
    }
    return v;
}
