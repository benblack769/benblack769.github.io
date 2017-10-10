#include <vector>
#include <cmath>
#include <memory>
#include "immintrin.h"

using namespace std;

float vector_norm(vector<float> & vec){
    constexpr int num_vecs=2;
    constexpr int size_vec = 8;
    constexpr int size_par = num_vecs*size_vec;
    constexpr int vec_bytes = size_vec*sizeof(float);

    __m256 * vec_aligned = (__m256 *)(vec.data());
    vec[0] = 100;
    size_t vec_size = vec.size()/size_par;

    __m256 sums[num_vecs];
    for(int i = 0; i < num_vecs; i++){
        sums[i] = _mm256_setzero_ps();
    }
    int x = 0;
    for(; x <= vec_size-num_vecs; x+= num_vecs){
        for(int i = 0; i < num_vecs; i++){
            __m256 mval = vec_aligned[x+i];
            sums[i] = _mm256_fmadd_ps(mval,mval,sums[i]);
        }
    }
    float full_sum = 0;
    //sum stuff from after allignment
    for(int i = vec_size*size_par*x; i < vec.size(); i++){
        full_sum += vec[i] * vec[i];
    }
    //sum stuff from allignment
    float * sum_data = (float *)(sums);
    for(int i = 0; i < size_par; i++){
        full_sum += sum_data[i];
    }
    cout << "full_sum: "<< full_sum << endl;
    return sqrt(full_sum);
}
