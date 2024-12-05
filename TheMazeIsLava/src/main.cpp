#include <VolcaniCore/Core/CommandLineArgs.h>

#include "Game.h"

Application* CreateApplication(const CommandLineArgs&) {
	// return new TheMazeIsLava::Game();
	return new Application();
}