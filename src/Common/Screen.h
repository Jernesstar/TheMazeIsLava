#pragma once

#include <VolcaniCore/Core/Time.h>
#include <VolcaniCore/Core/Defines.h>
#include <VolcaniCore/Core/Codes.h>

#include <Magma/UI/UIPage.h>

using namespace VolcaniCore;
using namespace Magma;

namespace TheMazeIsLava {

class Screen {
public:
	Func<void> OnLoad = [](){};
	Func<void, TimeStep> OnUpdate = [](TimeStep){};

public:
	Screen() = default;
	Screen(const std::string& pagePath);
	~Screen() = default;

	void OnRender();

	UI::UIPage& GetUI() { return m_UI; }
	Map<KeyCode, bool>& GetState() { return m_State; }

private:
	UI::UIPage m_UI;

	Map<KeyCode, bool> m_State;
};

}