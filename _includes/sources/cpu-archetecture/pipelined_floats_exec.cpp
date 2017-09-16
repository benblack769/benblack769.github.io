#include <vector>
#include "pipelined_floats.cpp"

using namespace std;

int main(){
    int size = 1000;
    int iters = 1000000;
    vector<double> vals(size,1.0);
    for(int i = 0; i < iters;i++){
        vector_scalar_mul(vals, 1.00001);
    }
}
