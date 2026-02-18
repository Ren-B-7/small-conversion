#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function declarations */
int usage_conv(void);
int usage_c2f(void);
int usage_f2c(void);
int usage_kg2lb(void);
int usage_lb2kg(void);
int usage_m2in(void);
int usage_in2m(void);
int usage_m2f(void);
int usage_f2m(void);

int c2f(char *input_c);
int f2c(char *input_f);
int kg2lb(char *input_kg);
int lb2kg(char *input_lb);
int m2in(char *input_m);
int in2m(char *input_in);
int m2f(char *input_m);
int f2m(char *input_f);

/* Usage functions */
int usage_conv(void)
{
	fprintf(stderr, "Usage: conv -t -c <value>   (Temperature: Celsius to Fahrenheit)\n");
	fprintf(stderr, "       conv -t -f <value>   (Temperature: Fahrenheit to Celsius)\n");
	fprintf(stderr, "       conv -w -k <value>   (Weight: Kilograms to Pounds)\n");
	fprintf(stderr, "       conv -w -l <value>   (Weight: Pounds to Kilograms)\n");
	fprintf(stderr, "       conv -d -m <value>   (Distance: Metres to Inches)\n");
	fprintf(stderr, "       conv -d -i <value>   (Distance: Inches to Metres)\n");
	fprintf(stderr, "       conv -d -M <value>   (Distance: Metres to Feet)\n");
	fprintf(stderr, "       conv -d -F <value>   (Distance: Feet to Metres)\n");
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

int usage_kg2lb(void)
{
	fprintf(stderr, "Usage: kg2lb <kilogram_value>\n");
	fprintf(stderr, "Convert Kilograms to Pounds\n");
	return 1;
}

int usage_lb2kg(void)
{
	fprintf(stderr, "Usage: lb2kg <pound_value>\n");
	fprintf(stderr, "Convert Pounds to Kilograms\n");
	return 1;
}

int usage_m2in(void)
{
	fprintf(stderr, "Usage: m2in <metre_value>\n");
	fprintf(stderr, "Convert Metres to Inches\n");
	return 1;
}

int usage_in2m(void)
{
	fprintf(stderr, "Usage: in2m <inch_value>\n");
	fprintf(stderr, "Convert Inches to Metres\n");
	return 1;
}

int usage_m2f(void)
{
	fprintf(stderr, "Usage: m2f <metre_value>\n");
	fprintf(stderr, "Convert Metres to Feet\n");
	return 1;
}

int usage_f2m(void)
{
	fprintf(stderr, "Usage: f2m <foot_value>\n");
	fprintf(stderr, "Convert Feet to Metres\n");
	return 1;
}

/* Conversion functions */
int c2f(char *input_c)
{
	char *endptr;
	double input;
	double output;
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

int f2c(char *input_f)
{
	char *endptr;
	double input;
	double output;
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

int kg2lb(char *input_kg)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_kg, &endptr);

	if (input_kg == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_kg);
		return 1;
	}

	output = input * 2.20462;
	printf("%.2f kg = %.2f lbs\n", input, output);
	return 0;
}

int lb2kg(char *input_lb)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_lb, &endptr);

	if (input_lb == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_lb);
		return 1;
	}

	output = input / 2.20462;
	printf("%.2f lbs = %.2f kg\n", input, output);
	return 0;
}

int m2in(char *input_m)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_m, &endptr);

	if (input_m == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_m);
		return 1;
	}

	output = input * 39.3701;
	printf("%.2f m = %.2f in\n", input, output);
	return 0;
}

int in2m(char *input_in)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_in, &endptr);

	if (input_in == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_in);
		return 1;
	}

	output = input / 39.3701;
	printf("%.2f in = %.2f m\n", input, output);
	return 0;
}

int m2f(char *input_m)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_m, &endptr);

	if (input_m == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_m);
		return 1;
	}

	output = input * 3.28084;
	printf("%.2f m = %.2f ft\n", input, output);
	return 0;
}

int f2m(char *input_f)
{
	char *endptr;
	double input;
	double output;
	errno = 0;

	input = strtod(input_f, &endptr);

	if (input_f == endptr || *endptr != '\0') {
		fprintf(stderr, "Error: '%s' is not a valid number.\n", input_f);
		return 1;
	}

	output = input / 3.28084;
	printf("%.2f ft = %.2f m\n", input, output);
	return 0;
}

/* Main function */
int main(int argc, char **argv)
{
	char *progname;

	/* Get the program name (basename) */
	progname = strrchr(argv[0], '/');
	if (progname) {
		progname++;
	} else {
		progname = argv[0];
	}

	/* Check if invoked as c2f */
	if (strcmp(progname, "c2f") == 0) {
		if (argc != 2) {
			return usage_c2f();
		}
		return c2f(argv[1]);
	}

	/* Check if invoked as f2c */
	if (strcmp(progname, "f2c") == 0) {
		if (argc != 2) {
			return usage_f2c();
		}
		return f2c(argv[1]);
	}

	/* Check if invoked as kg2lb */
	if (strcmp(progname, "kg2lb") == 0) {
		if (argc != 2) {
			return usage_kg2lb();
		}
		return kg2lb(argv[1]);
	}

	/* Check if invoked as lb2kg */
	if (strcmp(progname, "lb2kg") == 0) {
		if (argc != 2) {
			return usage_lb2kg();
		}
		return lb2kg(argv[1]);
	}

	/* Check if invoked as m2in */
	if (strcmp(progname, "m2in") == 0) {
		if (argc != 2) {
			return usage_m2in();
		}
		return m2in(argv[1]);
	}

	/* Check if invoked as in2m */
	if (strcmp(progname, "in2m") == 0) {
		if (argc != 2) {
			return usage_in2m();
		}
		return in2m(argv[1]);
	}

	/* Check if invoked as m2f */
	if (strcmp(progname, "m2f") == 0) {
		if (argc != 2) {
			return usage_m2f();
		}
		return m2f(argv[1]);
	}

	/* Check if invoked as f2m */
	if (strcmp(progname, "f2m") == 0) {
		if (argc != 2) {
			return usage_f2m();
		}
		return f2m(argv[1]);
	}

	/* Otherwise use conv behavior with flags */
	if (argc != 4) {
		return usage_conv();
	}

	/* Temperature conversions */
	if (argv[1][0] == '-' && argv[1][1] == 't') {
		if (argv[2][0] == '-' && argv[2][1] == 'c') {
			return c2f(argv[3]);
		} else if (argv[2][0] == '-' && argv[2][1] == 'f') {
			return f2c(argv[3]);
		} else {
			usage_conv();
			return 1;
		}
	}

	/* Weight conversions */
	if (argv[1][0] == '-' && argv[1][1] == 'w') {
		if (argv[2][0] == '-' && argv[2][1] == 'k') {
			return kg2lb(argv[3]);
		} else if (argv[2][0] == '-' && argv[2][1] == 'l') {
			return lb2kg(argv[3]);
		} else {
			usage_conv();
			return 1;
		}
	}

	/* Distance conversions */
	if (argv[1][0] == '-' && argv[1][1] == 'd') {
		if (argv[2][0] == '-' && argv[2][1] == 'm') {
			return m2in(argv[3]);
		} else if (argv[2][0] == '-' && argv[2][1] == 'i') {
			return in2m(argv[3]);
		} else if (argv[2][0] == '-' && argv[2][1] == 'M') {
			return m2f(argv[3]);
		} else if (argv[2][0] == '-' && argv[2][1] == 'F') {
			return f2m(argv[3]);
		} else {
			usage_conv();
			return 1;
		}
	}

	usage_conv();
	return 1;
}
