#include <vector>
#include <iostream>
#include "vector_mag16.cpp"

using namespace std;

int main(){
    int size = 1000;
    int iters = 10;
    vector<float> vals(1.0,size);
    for(int i = 0; i < size; i++){
        vals[i] = i+0.01;
    }
    float v = 0;
    for(int i = 0; i < iters;i++){
        v += vector_norm(vals);
        cout << v << endl;
        vals[int(v)%size] += 0.001;
    }
    return v;
}
