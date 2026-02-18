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

TARGET = conv
# Symlinks: temperature, weight, distance
LINKS = c2f f2c kg2lb lb2kg m2in in2m m2f f2m

.PHONY: all clean install test

all: $(TARGET) $(LINKS)

$(TARGET): conv.c
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $(TARGET) conv.c

# Create symlinks for all conversion tools
$(LINKS): $(TARGET)
	ln -sf $(TARGET) c2f
	ln -sf $(TARGET) f2c
	ln -sf $(TARGET) kg2lb
	ln -sf $(TARGET) lb2kg
	ln -sf $(TARGET) m2in
	ln -sf $(TARGET) in2m
	ln -sf $(TARGET) m2f
	ln -sf $(TARGET) f2m

install: $(TARGET) $(LINKS)
	mkdir -p $(HOME)/.local/bin
	install -m 755 $(TARGET) $(HOME)/.local/bin/
	ln -sf $(TARGET) $(HOME)/.local/bin/c2f
	ln -sf $(TARGET) $(HOME)/.local/bin/f2c
	ln -sf $(TARGET) $(HOME)/.local/bin/kg2lb
	ln -sf $(TARGET) $(HOME)/.local/bin/lb2kg
	ln -sf $(TARGET) $(HOME)/.local/bin/m2in
	ln -sf $(TARGET) $(HOME)/.local/bin/in2m
	ln -sf $(TARGET) $(HOME)/.local/bin/m2f
	ln -sf $(TARGET) $(HOME)/.local/bin/f2m

# Comprehensive tests
test: $(TARGET) $(LINKS)
	@echo "Testing temperature conversions..."
	@# Test C to F (c2f and conv -t -c)
	@for val in "100:212.00" "90:194.00" "80:176.00" "70:158.00" "60:140.00" "50:122.00" \
		"40:104.00" "30:86.00" "20:68.00" "10:50.00" "0:32.00" "-100:-148.00"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./c2f $$input | grep -q -- "$$expected" && echo "✓ c2f $$input passed" || echo "✗ c2f $$input failed"; \
		./conv -t -c $$input | grep -q -- "$$expected" && echo "✓ conv -t -c $$input passed" || echo "✗ conv -t -c $$input failed"; \
	done

	@# Test F to C (f2c and conv -t -f)
	@for val in "212:100.00" "194:90.00" "176:80.00" "158:70.00" "140:60.00" "122:50.00" \
		"104:40.00" "86:30.00" "68:20.00" "50:10.00" "32:0.00" "-148:-100.00"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./f2c $$input | grep -q -- "$$expected" && echo "✓ f2c $$input passed" || echo "✗ f2c $$input failed"; \
		./conv -t -f $$input | grep -q -- "$$expected" && echo "✓ conv -t -f $$input passed" || echo "✗ conv -t -f $$input failed"; \
	done

	@echo "Testing weight conversions..."
	@# Test kg to lb (kg2lb and conv -w -k)
	@for val in "1:2.20" "10:22.05" "50:110.23" "75:165.35" "100:220.46"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./kg2lb $$input | grep -q "$$expected" && echo "✓ kg2lb $$input passed" || echo "✗ kg2lb $$input failed"; \
		./conv -w -k $$input | grep -q "$$expected" && echo "✓ conv -w -k $$input passed" || echo "✗ conv -w -k $$input failed"; \
	done

	@# Test lb to kg (lb2kg and conv -w -l)
	@for val in "1:0.45" "10:4.54" "50:22.68" "75:34.02" "100:45.36"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./lb2kg $$input | grep -q "$$expected" && echo "✓ lb2kg $$input passed" || echo "✗ lb2kg $$input failed"; \
		./conv -w -l $$input | grep -q "$$expected" && echo "✓ conv -w -l $$input passed" || echo "✗ conv -w -l $$input failed"; \
	done

	@echo "Testing distance conversions..."
	@# Test m to in (m2in and conv -d -m)
	@for val in "1:39.37" "2:78.74" "5:196.85" "10:393.70"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./m2in $$input | grep -q "$$expected" && echo "✓ m2in $$input passed" || echo "✗ m2in $$input failed"; \
		./conv -d -m $$input | grep -q "$$expected" && echo "✓ conv -d -m $$input passed" || echo "✗ conv -d -m $$input failed"; \
	done

	@# Test in to m (in2m and conv -d -i)
	@for val in "1:0.03" "10:0.25" "50:1.27" "100:2.54"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./in2m $$input | grep -q "$$expected" && echo "✓ in2m $$input passed" || echo "✗ in2m $$input failed"; \
		./conv -d -i $$input | grep -q "$$expected" && echo "✓ conv -d -i $$input passed" || echo "✗ conv -d -i $$input failed"; \
	done

	@# Test m to f (m2f and conv -d -M)
	@for val in "1:3.28" "5:16.40" "10:32.81"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./m2f $$input | grep -q "$$expected" && echo "✓ m2f $$input passed" || echo "✗ m2f $$input failed"; \
		./conv -d -M $$input | grep -q "$$expected" && echo "✓ conv -d -M $$input passed" || echo "✗ conv -d -M $$input failed"; \
	done

	@# Test f to m (f2m and conv -d -F)
	@for val in "1:0.30" "5:1.52" "10:3.05"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./f2m $$input | grep -q "$$expected" && echo "✓ f2m $$input passed" || echo "✗ f2m $$input failed"; \
		./conv -d -F $$input | grep -q "$$expected" && echo "✓ conv -d -F $$input passed" || echo "✗ conv -d -F $$input failed"; \
	done

	@echo "All tests completed."

clean:
	rm -f $(TARGET) $(LINKS)
