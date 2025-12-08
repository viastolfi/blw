SRC = src
BUILD = build

CS = \
		 $(SRC)/main.c

OBJ = \
			$(BUILD)/main.o

CC = gcc
CFLAGS = -Wall -Wextra -g

.PHONY: all clean

all: $(BUILD)/blw

$(BUILD)/blw: $(OBJ)
	$(CC) -o $@ $^
	@$(BUILD)/blw

$(BUILD)/%.o: $(SRC)/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rm $(BUILD)
