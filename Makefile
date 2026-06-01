CC = clang
CFLAGS = -std=c2x -Wall -Wextra -g -Wno-unused-parameter
TARGET = main

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)

ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TEST_DIR := $(ROOT)tests

ifeq ($(DEBUG_PRINT_CODE),1)
	CFLAGS += -DDEBUG_PRINT_CODE
endif

ifeq ($(DEBUG_TRACE_EXECUTION),1)
	CFLAGS += -DDEBUG_TRACE_EXECUTION
endif

ifeq ($(DEBUG_STRESS_GC),1)
	CFLAGS += -DDEBUG_STRESS_GC
endif

ifeq ($(DEBUG_LOG_GC),1)
	CFLAGS += -DDEBUG_LOG_GC
endif

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
