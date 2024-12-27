#include "LevelRenderer.h"

namespace TheMazeIsLava {

void LevelRenderer::Update(TimeStep ts) {
	
}

void LevelRenderer::Render() {



	Renderer2D::DrawFullscreenQuad(m_Output, AttachmentTarget::Color);
}

}