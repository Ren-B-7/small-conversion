#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int usage_tempconv(void);
int usage_c2f(void);
int usage_f2c(void);
int c2f(char*);
int f2c(char*);

int usage_tempconv(void)
{
	fprintf(stderr, "Usage: tempconv -c <value>   (Celsius to Fahrenheit)\n");
	fprintf(stderr, "       tempconv -f <value>   (Fahrenheit to Celsius)\n");
	return 1;
}

int usage_c2f(void)
{
	fprintf(stderr, "Usage: c2f <celsius_value>\n");
	fprintf(stderr, "Convert Celsius to Fahrenheit\n");
	return 1;
}

int usage_f2c(void)
{
	fprintf(stderr, "Usage: f2c <fahrenheit_value>\n");
	fprintf(stderr, "Convert Fahrenheit to Celsius\n");
	return 1;
}

int c2f(char* input_c)
{
	char* endptr;
	double input, output;
	errno = 0;

	input = strtod(input_c, &endptr);

	if (input_c == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_c);
		return 1;
	}

	output = (input * 9.0 / 5.0) + 32.0;
	printf("%.2f°C = %.2f°F\n", input, output);
	return 0;
}

int f2c(char* input_f)
{
	char* endptr;
	double input, output;
	errno = 0;

	input = strtod(input_f, &endptr);

	if (input_f == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_f);
		return 1;
	}

	output = (input - 32.0) * 5.0 / 9.0;
	printf("%.2f°F = %.2f°C\n", input, output);
	return 0;
}

int main(int argc, char** argv)
{
	char* progname;

	/* Get the program name (basename) */
	progname = strrchr(argv[0], '/');
	if (progname) {
		progname++;
	} else {
		progname = argv[0];
	}

	/* Check if invoked as c2f */
	if (strcmp(progname, "c2f") == 0) {
		/* Celsius to Fahrenheit */
		if (argc != 2) {
			return usage_c2f();
		}
		return c2f(argv[1]);
	}

	/* Check if invoked as f2c */
	if (strcmp(progname, "f2c") == 0) {
		/* Fahrenheit to Celsius */
		if (argc != 2) {
			return usage_f2c();
		}
		return f2c(argv[1]);
	}

	/* Otherwise use original tempconv behavior */
	if (argc != 3) {
		return usage_tempconv();
	}

	if (argv[1][0] == '-' && argv[1][1] == 'c') {
		/* Celsius to Fahrenheit */
		return c2f(argv[2]);
	} else if (argv[1][0] == '-' && argv[1][1] == 'f') {
		/* Fahrenheit to Celsius */
		return f2c(argv[2]);
	} else {
		usage_tempconv();
		return 1;
	}

	return 0;
}
