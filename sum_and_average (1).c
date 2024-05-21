#include <stdio.h>

int main() {
	int n, i;
	double num, sum = 0.0, average;

	printf("How many numbers would you like to enter? ");
	scanf("%d", &n);

		for (i = 1; i <= n; ++i) {
			printf("please enter the next number: ");
			scanf("%lf", &num);
			sum += num;
		}

		average = sum / n;

		printf("\n The sum of the entered numbers is: %f\n", sum);
		printf("\n the average of the numbers entered is: %f\n", average);

		return 0;
}
