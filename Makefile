CC = gcc
# Strict compilation flags
CFLAGS = -std=c90 \
         -pedantic \
         -pedantic-errors \
         -Wall \
         -Wextra \
         -Werror \
         -Wformat=2 \
         -Wformat-security \
         -Wnull-dereference \
         -Wstack-protector \
         -Wtrampolines \
         -Walloca \
         -Wvla \
         -Warray-bounds=2 \
         -Wimplicit-fallthrough=3 \
         -Wtraditional-conversion \
         -Wshift-overflow=2 \
         -Wcast-qual \
         -Wcast-align=strict \
         -Wconversion \
         -Wsign-conversion \
         -Wlogical-op \
         -Wduplicated-cond \
         -Wduplicated-branches \
         -Wrestrict \
         -Wnested-externs \
         -Winline \
         -Wundef \
         -Wstrict-prototypes \
         -Wmissing-prototypes \
         -Wmissing-declarations \
         -Wredundant-decls \
         -Wshadow \
         -Wwrite-strings \
         -Wfloat-equal \
         -Wpointer-arith \
         -Wbad-function-cast \
         -Wold-style-definition

# Security hardening flags
HARDENING = -D_FORTIFY_SOURCE=2 \
            -fstack-protector-strong \
            -fPIE \
            -fstack-clash-protection \
            -fcf-protection

# Linker hardening flags
LDFLAGS = -Wl,-z,relro \
          -Wl,-z,now \
          -Wl,-z,noexecstack \
          -Wl,-z,separate-code \
          -pie

# Optimization
OPTFLAGS = -O2 -march=native

# Combine all flags
ALL_CFLAGS = $(CFLAGS) $(HARDENING) $(OPTFLAGS)

TARGET = tempconv
LINKS = c2f f2c

.PHONY: all clean install test

all: $(TARGET) $(LINKS)

$(TARGET): tempconv.c
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $(TARGET) tempconv.c

# Create symlinks for c2f and f2c
$(LINKS): $(TARGET)
	ln -sf $(TARGET) c2f
	ln -sf $(TARGET) f2c

install: $(TARGET) $(LINKS)
	mkdir -p $(HOME)/.local/bin
	install -m 755 $(TARGET) $(HOME)/.local/bin/
	ln -sf $(TARGET) $(HOME)/.local/bin/c2f
	ln -sf $(TARGET) $(HOME)/.local/bin/f2c

# Basic tests
test: $(TARGET) $(LINKS)
	@echo "Testing conversions..."
	@# Test C to F (c2f and tempconv -c)
	@for val in "100:212.00" "90:194.00" "80:176.00" "70:158.00" "60:140.00" "50:122.00" \
		"40:104.00" "30:86.00" "20:68.00" "10:50.00" "0:32.00" "-100:-148.00"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./c2f $$input | grep -q -- "$$expected" && echo "✓ c2f $$input passed" || echo "✗ c2f $$input failed"; \
		./tempconv -c $$input | grep -q -- "$$expected" && echo "✓ tempconv -c $$input passed" || echo "✗ tempconv -c $$input failed"; \
	done

	@# Test F to C (f2c and tempconv -f)
	@for val in "212:100.00" "194:90.00" "176:80.00" "158:70.00" "140:60.00" "122:50.00" \
		"104:40.00" "86:30.00" "68:20.00" "50:10.00" "32:0.00" "-148:-100.00"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./f2c $$input | grep -q -- "$$expected" && echo "✓ f2c $$input passed" || echo "✗ f2c $$input failed"; \
		./tempconv -f $$input | grep -q -- "$$expected" && echo "✓ tempconv -f $$input passed" || echo "✗ tempconv -f $$input failed"; \
	done
	@echo "All tests completed."

clean:
	rm -f $(TARGET) $(LINKS)