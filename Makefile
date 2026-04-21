CC = clang
CFLAGS = -std=c2x -Wall -Wextra -g
TARGET = main

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)

ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TEST_DIR := $(ROOT)tests

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)


# run: $(TARGET)
# 	@start=$$(date +%s%3N); \
# 	./$(TARGET) $(FILE); \
# 	end=$$(date +%s%3N); \
# 	echo "Execution time: $$(($$end - $$start)) ms"

run: $(TARGET)
	@start=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	./$(TARGET) $(FILE); \
	end=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	echo "Execution time: $$(($$end - $$start)) ms"

CC = clang
CFLAGS = -std=c2x -Wall -Wextra -g
TARGET = main

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)

run: $(TARGET)
	@start=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	./$(TARGET) $(FILE); \
	end=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	echo "Execution time: $$(($$end - $$start)) ms"

run-tests: $(TARGET)
	@totalStart=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	for f in $(TEST_DIR)/*; do \
		echo "Running $$f"; \
		testStart=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
		$(MAKE) run FILE="$$f" || true; \
		testEnd=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
		echo "Test runtime: $$(($$testEnd - $$testStart)) ms"; \
	done; \
	totalEnd=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	echo "Total runtime: $$(($$totalEnd - $$totalStart)) ms"
