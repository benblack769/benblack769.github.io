#include <vector>
using namespace std;

void vector_scalar_mul(vector<double> & vec, double scalar){
    int vec_size = vec.size();
    for(int x = 0; x < vec_size; x++){
        vec[x] *= scalar;
    }
}
