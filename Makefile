SRC = src
BUILD = build
RAYLIB_FOLDER = raylib-5.5_linux_amd64

CS = \
		 $(SRC)/main.c

OBJ = \
			$(BUILD)/main.o

CC = gcc
CFLAGS = -Wall -Wextra -g

.PHONY: all clean

all: $(BUILD)/blw

$(BUILD)/blw: $(OBJ)
	$(CC) -o $@ $^ -L$(RAYLIB_FOLDER)/lib -l:libraylib.a -lm

$(BUILD)/%.o: $(SRC)/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@ -I$(RAYLIB_FOLDER)/include

clean:
	rm -rf $(BUILD)
