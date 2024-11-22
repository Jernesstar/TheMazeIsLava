#include "Asset.h"

namespace TheMazeIsLava {

void Asset::Init() {
	std::string assetPath = "TheMazeIsLava/assets/";

	auto tex = Texture::Create(assetPath + "images/stone.png");
	auto tex2 = Texture::Create(assetPath + "images/lava.png");
	
	Wall = Model::Create("");
	Path = Model::Create("");
	Lava = Model::Create("");

	Wall->AddMesh(Mesh::Create(MeshPrimitive::Cube, Material{ .Diffuse = tex }));
	// TODO(Codespace): Find an actual path tile
	Path->AddMesh(Mesh::Create(MeshPrimitive::Cube, Material{ .Diffuse = tex }));
	Lava->AddMesh(Mesh::Create(MeshPrimitive::Cube, Material{ .Diffuse = tex2 }));

	Player = Model::Create(assetPath + "models/player/Knight_Golden_Male.obj");
	Torch  = Model::Create(assetPath + "models/torch/torch.obj");
	Stairs = Model::Create(assetPath + "models/stairs/stairs.obj");
}

}