#include "LevelRenderer.h"

#include <VolcaniCore/Graphics/Renderer.h>
#include <VolcaniCore/Graphics/Renderer2D.h>
#include <VolcaniCore/Graphics/Renderer3D.h>

namespace TheMazeIsLava {

void LevelRenderer::Update(TimeStep ts) {
	
}

void LevelRenderer::Render() {



	Renderer2D::DrawFullscreenQuad(m_Output, AttachmentTarget::Color);
}

}