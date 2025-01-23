#pragma once

#include <Lava/App.h>

#include <Common/Screen.h>
#include <Common/LevelRenderer.h>

using namespace VolcaniCore;
using namespace Magma;

namespace TheMazeIsLava {

class Game : public Lava::App {
public:
	LevelRenderer Renderer;

public:
	void OnLoad() override;
	void OnClose() override;
	void OnUpdate(TimeStep ts) override;

private:
	void SetScreen(Screen& screen);
	void LoadScreens();

private:
	Screen* m_CurrentScreen;

	Screen EmptyScreen;
	Screen HomeScreen;
	Screen LevelScreen;
	Screen PlayScreen;
	Screen OverScreen;
};

}