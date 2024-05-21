#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) 
{
	if (argc < 3 || argc > 4) 
	{
		printf("Usage: %s start stop [step]\n", argv[0]);
		return 1;
	}
	double start = atof(argv[1]);
	double stop = atof(argv[2]);
	double step = (argc == 4) ? atof(argv[3]) : 1.0;

	if (start > stop && step > 0.0) 
	{
		printf("Error: start temperature is higher than stop temperaturebut step is positive \n");
		return 1;
	}
       		else if (start < stop && step < 0.0) {
		printf("Error: start temp is lower than stop temp but step is negative \n");
		return 1; }

		else if (step == 0.0) {
			printf("Error step cannot be zero\n");
			return 1; }
	printf("F\tC\n");
	
	for (double t= start; (step > 0.0 && t <= stop) || (step < 0.0 && t >= stop); t+= step) {
			double C = (5.0 / 9.0) * (t - 32.0);
			printf("%.1f\t\t%.1f\n", t, C); }
			return 0; }
