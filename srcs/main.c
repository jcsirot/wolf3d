/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: qbenaroc <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/05/03 13:35:48 by qbenaroc          #+#    #+#             */
/*   Updated: 2019/06/08 20:09:05 by brpinto          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <wolf3d.h>

int		main(int ac, char **av)
{
	(void)ac;
	(void)av;
	SDL_Window *window;
	SDL_Surface *window_surface;
	SDL_Event e;
	int open;

	open = 1;
	SDL_Init(SDL_INIT_VIDEO);
	window = SDL_CreateWindow("Wolf3D", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 640, 480, 0);
	
	window_surface = SDL_GetWindowSurface(window);
	while (open)
	{
		while (SDL_PollEvent(&e) > 0)
		{
			switch(e.type)
			{
				case SDL_QUIT:
					open = 0;
					break;
			}
			SDL_UpdateWindowSurface(window);
		}
	}
	SDL_UpdateWindowSurface(window);
	SDL_Delay(10000);
	return (0);
}
