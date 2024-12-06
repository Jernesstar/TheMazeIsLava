#include "Screen.h"

#include <VolcaniCore/Event/Events.h>

#include <Magma/UI/UIRenderer.h>

namespace TheMazeIsLava {

Screen::Screen(const std::string& pagePath)
	: m_UI(pagePath)
{
	Events::RegisterListener<KeyPressedEvent>(
		[&](const KeyPressedEvent& event)
		{
			// if(event.Key == Key::Return && !event.IsRepeat)
			// 	m_State.ReturnPressed = true;
		});
}

void Screen::OnRender() {
	UI::UIRenderer::BeginFrame();
	m_UI.Render();
	UI::UIRenderer::EndFrame();
}

}