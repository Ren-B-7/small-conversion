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
LINKS = c2f f2c k2l l2k m2i i2m m2f f2m

.PHONY: all clean install test

all: $(TARGET) $(LINKS)

$(TARGET): conv.c
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $(TARGET) conv.c

# Create symlinks for all conversion tools
$(LINKS): $(TARGET)
	ln -sf $(TARGET) c2f
	ln -sf $(TARGET) f2c
	ln -sf $(TARGET) k2l
	ln -sf $(TARGET) l2k
	ln -sf $(TARGET) m2i
	ln -sf $(TARGET) i2m
	ln -sf $(TARGET) m2f
	ln -sf $(TARGET) f2m

install: $(TARGET) $(LINKS)
	mkdir -p $(HOME)/.local/bin
	install -m 755 $(TARGET) $(HOME)/.local/bin/
	ln -sf $(TARGET) $(HOME)/.local/bin/c2f
	ln -sf $(TARGET) $(HOME)/.local/bin/f2c
	ln -sf $(TARGET) $(HOME)/.local/bin/k2l
	ln -sf $(TARGET) $(HOME)/.local/bin/l2k
	ln -sf $(TARGET) $(HOME)/.local/bin/m2i
	ln -sf $(TARGET) $(HOME)/.local/bin/i2m
	ln -sf $(TARGET) $(HOME)/.local/bin/m2f
	ln -sf $(TARGET) $(HOME)/.local/bin/f2m

# Comprehensive tests
test: $(TARGET) $(LINKS)
	@echo "Testing temperature conversions..."
	@# Test C to F (c2f and conv -t -c)
	@for val in "100:212.000000" "90:194.000000" "80:176.000000" "70:158.000000" "60:140.000000" "50:122.000000" \
		"40:104.000000" "30:86.000000" "20:68.000000" "10:50.000000" "0:32.000000" "-100:-148.000000"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./c2f $$input | grep -q -- "$$expected" && echo "✓ c2f $$input passed" || echo "✗ c2f $$input failed"; \
		./conv -t -c $$input | grep -q -- "$$expected" && echo "✓ conv -t -c $$input passed" || echo "✗ conv -t -c $$input failed"; \
	done

	@# Test F to C (f2c and conv -t -f)
	@for val in "212:100.000000" "194:90.000000" "176:80.000000" "158:70.000000" "140:60.000000" "122:50.000000" \
		"104:40.000000" "86:30.000000" "68:20.000000" "50:10.000000" "32:0.000000" "-148:-100.000000"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./f2c $$input | grep -q -- "$$expected" && echo "✓ f2c $$input passed" || echo "✗ f2c $$input failed"; \
		./conv -t -f $$input | grep -q -- "$$expected" && echo "✓ conv -t -f $$input passed" || echo "✗ conv -t -f $$input failed"; \
	done

	@echo "Testing weight conversions..."
	@# Test kg to lb (k2l and conv -w -k)
	@for val in "1:2.204623" "10:22.046226" "50:110.231131" "75:165.346697" "100:220.462262"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./k2l $$input | grep -q "$$expected" && echo "✓ k2l $$input passed" || echo "✗ k2l $$input failed"; \
		./conv -w -k $$input | grep -q "$$expected" && echo "✓ conv -w -k $$input passed" || echo "✗ conv -w -k $$input failed"; \
	done

	@# Test lb to kg (l2k and conv -w -l)
	@for val in "1:0.453592" "10:4.535924" "50:22.679618" "75:34.019428" "100:45.359237"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./l2k $$input | grep -q "$$expected" && echo "✓ l2k $$input passed" || echo "✗ l2k $$input failed"; \
		./conv -w -l $$input | grep -q "$$expected" && echo "✓ conv -w -l $$input passed" || echo "✗ conv -w -l $$input failed"; \
	done

	@echo "Testing distance conversions..."
	@# Test m to in (m2i and conv -d -m)
	@for val in "1:39.370079" "2:78.740157" "5:196.850394" "10:393.700787"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./m2i $$input | grep -q "$$expected" && echo "✓ m2i $$input passed" || echo "✗ m2i $$input failed"; \
		./conv -d -m $$input | grep -q "$$expected" && echo "✓ conv -d -m $$input passed" || echo "✗ conv -d -m $$input failed"; \
	done

	@# Test in to m (i2m and conv -d -i)
	@for val in "1:0.025400" "10:0.254000" "50:1.270000" "100:2.540000"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./i2m $$input | grep -q "$$expected" && echo "✓ i2m $$input passed" || echo "✗ i2m $$input failed"; \
		./conv -d -i $$input | grep -q "$$expected" && echo "✓ conv -d -i $$input passed" || echo "✗ conv -d -i $$input failed"; \
	done

	@# Test m to f (m2f and conv -d -M)
	@for val in "1:3.280840" "5:16.404199" "10:32.808399"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./m2f $$input | grep -q "$$expected" && echo "✓ m2f $$input passed" || echo "✗ m2f $$input failed"; \
		./conv -d -M $$input | grep -q "$$expected" && echo "✓ conv -d -M $$input passed" || echo "✗ conv -d -M $$input failed"; \
	done

	@# Test f to m (f2m and conv -d -F)
	@for val in "1:0.304800" "5:1.524000" "10:3.048000"; do \
		input=$${val%%:*}; expected=$${val#*:}; \
		./f2m $$input | grep -q "$$expected" && echo "✓ f2m $$input passed" || echo "✗ f2m $$input failed"; \
		./conv -d -F $$input | grep -q "$$expected" && echo "✓ conv -d -F $$input passed" || echo "✗ conv -d -F $$input failed"; \
	done

	@echo "All tests completed."

clean:
	rm -f $(TARGET) $(LINKS)
