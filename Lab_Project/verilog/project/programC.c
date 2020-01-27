#define MILSPERCLOCK 32768

volatile char houraddr = 770;
volatile char pushaddr = 530;
short y;

void delay(short miliseconds)
{

	y = miliseconds;
	while (y--)
		;
}

void main()
{

	int *min0 = (int *)houraddr;
	int *min1 = (int *)(houraddr + 1);
	int *hour0 = (int *)(houraddr + 2);
	int *hour1 = (int *)(houraddr + 3);
	int *push = (int *)pushaddr;
	char lastpush = 0;
	

	while (1)
	{
		lastpush = *push; 

		if (lastpush == 1)
		{
			if (*min0 == 9)
			{
				*min0 = 0;
				*min1 = *min1 + 1;
			}
			else
			{
				*min0 = *min0 + 1;
			}
		}
		else if (lastpush == 2)
		{
			if (*hour1 == 2)
			{
				if (*hour0 == 3)
				{
					*hour0 = 0;
					*hour1 = 0;
				}
				else
				{
					*hour0 = *hour0 + 1;
				}
			}
			else
			{
				if (*hour0 == 9)
				{
					*hour0 = 0;
					*hour1 = *hour1 + 1;
				}
				else
				{
					*hour0 = *hour0 + 1;
				}
			}
		}
		delay(MILSPERCLOCK);
	}
	while (1){}

	return;
}
