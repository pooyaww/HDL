#include <stdlib.h>
#include <stdio.h>

#define FILTER_LEN  8
double *gh;
double *gx;
int idxFilter;

void filter(double iX, double *oY) {
    double xAcc;

    // Insert data into pipe
    gx[idxFilter] =  iX;
    idxFilter++;
    idxFilter%=FILTER_LEN;

    xAcc = 0.0;
    for(int idx=0;idx<FILTER_LEN;idx++) {
        int idxPipe = (idxFilter + idx) % FILTER_LEN;
        int idxH    = FILTER_LEN - 1 - idx;
        xAcc += (gx[idxPipe] * gh[idxH]);
    };
    *oY = xAcc;
}

int main(void) {
    gh = new double[FILTER_LEN];
    gx = new double[FILTER_LEN];
    for(int idx=0;idx<FILTER_LEN;idx++) {
        gh[idx] = 1;
        gx[idx] = 0;
    };


    double testData = 0;
    idxFilter = 0;
    double oY;

    for(int i=0; i<32; i++) {
        testData = testData+1;
        filter(testData, &oY);
        oY /= FILTER_LEN;

        printf("Input = %3.3f  => Filtered output = %3.3f\n",testData, oY);
    }

}
