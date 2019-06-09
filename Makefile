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

SDL_MAIN_DOWNLOAD = https://www.libsdl.org/release/SDL2-2.0.9.tar.gz

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
MLX_PATH = ./srcs/SDL2-2.0.9/include/

	# Files

SRC_FILES = $(shell ls $(SRC_PATH) | grep -E ".+\.c")

#MLX_FILE = -L /Users/$(ID_UN)/.brew/lib/ -lSDL2

#MLX = $(addprefix -I, $(MLX_PATH))

LIB_FILE = libft.a
MLX_FILE = -L ./srcs/SDL2-2.0.9/lib -lSDL2

LIB = $(addprefix $(LIB_PATH), $(LIB_FILE))

OBJ_FILES = $(SRC_FILES:.c=.o)
	OBJ_EXEC = $(addprefix $(OBJ_PATH), $(OBJ_FILES))

	# Rules

all: sdl $(NAME)

$(OBJ_PATH):
	@mkdir $(OBJ_PATH) 2> /dev/null || true

$(OBJ_PATH)%.o: $(SRC_PATH)%.c
	@$(CC) $(FLAGS) -c $< -o $@ -I $(HEADER_PATH) -I $(LIB_PATH)includes/ -I $(MLX_PATH)
	@echo "\033[1;34mCompilation of \033[36m$(notdir $<)\033[0m \033[32mdone\033[1;0m"

$(LIB):
	@make -C $(LIB_PATH)

#$(MLX):
#	@make -C ./srcs/SDL2-2.0.9/build/

$(NAME): $(LIB) $(OBJ_PATH) $(OBJ_EXEC) $(HEADER_PATH)
	@$(CC) $(FLAGS) $(OBJ_EXEC) $(LIB) -o $@ -I $(HEADER_PATH) $(MLX_FILE)
	@echo "\033[1;32mwolf3d\t\t\033[0;32m[Compilation done]\033[1;0m"

sdl:
	@if [ -d "./srcs/SDL2-2.0.9/lib/" ]; then \
		echo "SDL ==> Nothing to be done"; \
	else \
		echo "SDL ==> Downloading SDL" && \
		curl -s $(SDL_MAIN_DOWNLOAD) -O && \
		mv SDL2-2.0.9.tar.gz srcs && \
		cd ./srcs && \
		echo "SDL ==> Compilation SDL main" && \
		tar -xf SDL2-2.0.9.tar.gz && \
		cd SDL2-2.0.9 && \
		./configure --prefix=$(shell pwd)/srcs/SDL2-2.0.9 > /dev/null && \
		$(MAKE) > /dev/null &&  \
		$(MAKE) install > /dev/null && \
		echo "SDL ==> DONE"; \
fi

clean:
	@make clean -C libft/
	@/bin/rm -rf $(OBJ_PATH)
	@echo "\033[1;32mwolf3d\t\t\033[1;31m[.o removed]\033[1;0m"

fclean: clean
	@make fclean -C libft
	@/bin/rm -rf $(NAME)
	@echo "\033[1;32mwolf3d\t\t\033[1;31m[Executable removed]\033[1;0m"

re: fclean all

.PHONY: all, clean, fclean, re
