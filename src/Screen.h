#pragma once

#include <VolcaniCore/Core/Time.h>

#include <Magma/UI/UIPage.h>

using namespace VolcaniCore;
using namespace Magma;

namespace TheMazeIsLava {

class Screen {
public:
	std::function<void(void)> OnLoad = [](){};
	std::function<void(TimeStep)> OnUpdate = [](TimeStep){};

public:
	Screen() = default;
	Screen(const std::string& pagePath);
	~Screen() = default;

	void OnRender();

	UI::UIPage& GetUI() { return m_UI; }

private:
	UI::UIPage m_UI;
};

}