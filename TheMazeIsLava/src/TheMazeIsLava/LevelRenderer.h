#pragma once

#include <Magma/Scene/Scene.h>

using namespace VolcaniCore;
using namespace Magma;

namespace TheMazeIsLava {

class LevelRenderer : public SceneRenderer {
public:
	void Update(TimeStep ts) override;
	void Render() override;
};

}