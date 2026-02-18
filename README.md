## tempconv

Small c based library, has 1 binary and 8 symlinks.

- binary
  - conv
- symlinks
  - c2f
  - f2c
  - k2l
  - l2k
  - m2i
  - i2m
  - m2f
  - f2m

```bash
conv -t -c {celsius}      # Celsius to Fahrenheit
c2f {celsius}             # Celsius to Fahrenheit

conv -t -f {fahrenheit}   # Fahrenheit to Celsius
f2c {fahrenheit}          # Fahrenheit to Celsius

conv -w -k {kilograms}    # Kilograms to Pounds
k2l {kilograms}           # Kilograms to Pounds

conv -w -l {pounds}       # Pounds to Kilograms
l2k {pounds}              # Pounds to Kilograms

conv -d -m {metres}       # Metres to Inches
m2i {metres}              # Metres to Inches

conv -d -i {inches}       # Inches to Metres
i2m {inches}              # Inches to Metres

conv -d -M {metres}       # Metres to Feet
m2f {metres}              # Metres to Feet

conv -d -F {feet}         # Feet to Metres
f2m {feet}                # Feet to Metres
```

### Build and Install

**Build:**

```bash
make
```

**Run tests:**

```bash
make test
```

**Install to `~/.local/bin/`:**

```bash
make install
```

**Clean build artifacts:**

```bash
make clean
```

### Further notes

To change the link names the MakeFile and the C code has to be adjusted.  
Handles floating point operations and prints to 2 decimals
