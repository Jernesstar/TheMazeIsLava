#pragma once

#include <VolcaniCore/Graphics/Model.h>

using namespace VolcaniCore;

namespace TheMazeIsLava {

class Asset {
public:
	static void Init();

public:
	inline static Ref<Model> Wall;
	inline static Ref<Model> Path;
	inline static Ref<Model> Lava;

	inline static Ref<Model> Player;
	inline static Ref<Model> Torch;
	inline static Ref<Model> Stairs;
};

}