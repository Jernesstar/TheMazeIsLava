#include "Screen.h"

#include <VolcaniCore/Event/Events.h>

#include <Magma/UI/UIRenderer.h>

namespace TheMazeIsLava {

Screen::Screen(const std::string& pagePath) {
	Events::RegisterListener<KeyPressedEvent>(
		[&](const KeyPressedEvent& event)
		{
			if(!event.IsRepeat)
				m_State[event.Key] = true;
		});
}

void Screen::OnRender() {
	m_UI.Render();
}

}