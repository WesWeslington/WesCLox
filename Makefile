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


# run: $(TARGET)
# 	@start=$$(date +%s%3N); \
# 	./$(TARGET); \
# 	end=$$(date +%s%3N); \
# 	echo "Execution time: $$(($$end - $$start)) ms"

run: $(TARGET)
	@start=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	./$(TARGET); \
	end=$$(python3 -c 'import time; print(int(time.time()*1000))'); \
	echo "Execution time: $$(($$end - $$start)) ms"
