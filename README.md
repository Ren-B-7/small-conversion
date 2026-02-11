## tempconv
Small c based library, has 3 binaries.
tempconv, c2f and f2c.
```bash
tempconv -c {celsius}
tempconv -f {fahrenheit}
c2f {celsius}
f2c {fahrenheit}
```

The c2f and f2c binaries are symlinks to the tempconv binary.
Make file has an install option to copy and install to ``~/.local/bin/``
