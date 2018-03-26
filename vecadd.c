//#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
int i=0;

void vecAdd(float *h_A, float *h_B, float *h_C,int n){
	for(i=0;i<n;i++){
		h_C[i]=h_A[i]+h_B[i];
		printf("%lf",h_C[i]);
	}
}
int main(){
	float *h_A,*h_B,*h_C;
	int n=4;

	h_A = (float *)malloc(n* sizeof(float));
	h_B = (float *)malloc(n* sizeof(float));
	h_C = (float *)malloc(n* sizeof(float));
	for(i=0;i<n;i++){
		h_A[i]=(float)i;
		h_B[i]=i;
		printf("%f",h_A[i]);
	}
	vecAdd(h_A,h_B,h_C,n);
}
