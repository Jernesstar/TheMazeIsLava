#include "Game.h"

Application* CreateApplication(const CommandLineArgs&) {
	return new TheMazeIsLava::Game();
}