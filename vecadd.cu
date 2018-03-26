#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>

__global__
void vecAddKernel(float *A,float * B,float *C,int n){
	int i=threadIdx.x+blockDim.x+blockIdx.x;
	if(i<n){
		C[i]=A[i]+B[i];
	}
}
// & address * value;
void vecAdd(float *h_A, float *h_B, float *h_C,int n){
	int size= n * sizeof(float);
	float *d_A,*d_B,*d_C;
	cudaMalloc((void**)&d_A,size);
	cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
	cudaMalloc((void**)&d_B,size);
	cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice);
	cudaError_t err=cudaMalloc((void**)&d_C,size);
	/*if(err!=cudaSuccess){
		printf("error");
		exit(EXIT_FAILURE);
	}*/

	vecAddKernel<<<ceil(n/256.0),256>>>(d_A,d_B,d_C,n);
	cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);
	/*for(i=0;i<n;i++){
		h_C[i]=h_A[i]+h_B[i];
		printf("%lf",h_C[i]);
	}*/
	cudaFree(d_C);
	cudaFree(d_A);
	cudaFree(d_B);
}
int main(){
	float *h_A,*h_B,*h_C;
	int n=4;

	h_A = (float *)malloc(n* sizeof(float));
	h_B = (float *)malloc(n* sizeof(float));
	h_C = (float *)malloc(n* sizeof(float));
	vecAdd(h_A,h_B,h_C,n);
	for(int i=0;i<n;i++){
		
		printf("%f ",h_C[i]);
	}
	free(h_A);
	free(h_B);
	free(h_C);
}
