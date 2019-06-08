# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qbenaroc <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/05/03 13:32:26 by qbenaroc          #+#    #+#              #
#    Updated: 2019/06/08 18:50:03 by brpinto          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	# Binary

NAME = wolf3d

	# Flags

FLAGS = -Wall -Wextra -Werror
CC = gcc
#MLX_FLAGS = ./minilibx_macos/libmlx.a -framework OpenGL -framework Appkit

ID_UN = $(shell id -un)

	# Paths

SDL_NUM = $(shell ls /Users/$(ID_UN)/.brew/Cellar/sdl2/ | tail -1)

HEADER_PATH = ./includes/
SRC_PATH = ./srcs/
OBJ_PATH = ./objs/
LIB_PATH = ./libft/
MLX_PATH = /Users/$(ID_UN)/.brew/Cellar/sdl2/$(SDL_NUM)/include/SDL2

	# Files

SRC_FILES = $(shell ls $(SRC_PATH) | grep -E ".+\.c")

MLX_FILE = -L /Users/$(ID_UN)/.brew/lib/ -lSDL2

MLX = $(addprefix -I, $(MLX_PATH))

LIB_FILE = libft.a

LIB = $(addprefix $(LIB_PATH), $(LIB_FILE))

OBJ_FILES = $(SRC_FILES:.c=.o)
	OBJ_EXEC = $(addprefix $(OBJ_PATH), $(OBJ_FILES))

	# Rules

all: $(NAME)

$(OBJ_PATH):
	@mkdir $(OBJ_PATH) 2> /dev/null || true

$(OBJ_PATH)%.o: $(SRC_PATH)%.c
	@$(CC) $(FLAGS) -c $< -o $@ -I $(HEADER_PATH) -I $(LIB_PATH)includes/ $(MLX)
	@echo "\033[1;34mCompilation of \033[36m$(notdir $<)\033[0m \033[32mdone\033[0m"

$(LIB):
	@make -C $(LIB_PATH)

#$(MLX):
#	@make -C $(MLX_PATH)

$(NAME): $(LIB) $(OBJ_PATH) $(OBJ_EXEC) $(HEADER_PATH)
	@$(CC) $(FLAGS) $(OBJ_EXEC) $(LIB) -o $@ -I $(HEADER_PATH) $(MLX_FILE)
	@echo "\033[1;32mwolf3d\t\t\033[0;32m[Compilation done]\033[0;32m"

clean:
	@make clean -C libft/
	@/bin/rm -rf $(OBJ_PATH)
	@echo "\033[1;32mwolf3d\t\t\033[1;31m[.o removed]"

fclean: clean
	@make fclean -C libft
	@/bin/rm -rf $(NAME)
	@echo "\033[1;32mwolf3d\t\t\033[1;31m[Executable removed]"

re: fclean all

.PHONY: all, clean, fclean, re
