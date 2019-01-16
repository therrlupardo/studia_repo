#include <stdio.h>
extern float miesz2float(long long);

int main()
{	
	printf("12.5=%f\n", miesz2float(53687091200)); 
	printf("0.5=%f\n", miesz2float(2147483648));  

	
	return 0;
}
