#include "Level.h"

#include <VolcaniCore/Graphics/Renderer.h>
#include <VolcaniCore/Graphics/Renderer2D.h>
#include <VolcaniCore/Graphics/Renderer3D.h>

#include <Magma/ECS/EntityBuilder.h>

#include <App/Game.h>

using namespace Magma::ECS;
using namespace Magma::Physics;

namespace TheMazeIsLava {

Level::Level(const std::string& name, const Tilemap& map)
	: Name(name), Width(map[0].size()), Height(map.size()), Map(map)
{
	TraverseTilemap(
		[&](const Tile& tile)
		{
			if(IsLava(tile))  LavaPoints.push_back(tile);
			if(IsGoal(tile))  Goal = tile;
			if(IsStart(tile)) PlayerStart = tile;
		});
}

void Level::OnUpdate(TimeStep ts) {
	// game->Renderer.Update(ts);

	if(m_Scene)
		m_Scene->OnUpdate(ts);
}

void Level::OnRender() {
	if(!m_Scene)
		return;

	// auto* game = Application::As<Game>();
	// m_Scene->OnRender(game->Renderer);

	// Ref<Framebuffer> output = game->Renderer.GetOutput();
	// Renderer2D::DrawFullscreenQuad(output, AttachmentTarget::Color);
}

void Level::TraverseTilemap(const Func<void, const Tile&>& func) {
	for(uint32_t i = 0; i < Height; i++)
		for(uint32_t j = 0; j < Width; j++)
			func(Tile(j, i));
}

void Level::Load() {
	m_Scene = CreateRef<Scene>(Name);

	auto& world = m_Scene->EntityWorld;
	TraverseTilemap(
		[&](const Tile& tile)
		{
			auto [x, y] = tile;

			if(IsWall(tile)) {
				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y }
					})
				// .Add<MeshComponent>(Asset::Wall)
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
			else if(IsPath(tile) || IsStart(tile)) {
				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 0.0f, y },
						// .Rotation = OrientPath(tile)
					})
				// .Add<MeshComponent>(Asset::Path)
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				// .Add<MeshComponent>(PickPathMesh(tile))
				.Finalize();
			}
			else if(IsLava(tile)) {
				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y }
					})
				// .Add<MeshComponent>(Asset::Lava)
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
			else if(IsGoal(tile)) {
				world.BuildEntity("Goal")
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y },
						// .Rotation = OrientStairs(tile),
						.Scale = glm::vec3(0.5)
					})
				.Add<MeshComponent>("Goal")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
		});
}

glm::vec3 Level::OrientPath(const Tile& tile) {

}

glm::vec3 Level::OrientStairs(const Tile& tile) {

}

void Level::PropagateLava(TimeStep ts) {
	// TODO(Implement): Smooth lava

}

// 0 -> Wall
// 1 -> Path
// 2 -> Lava
// 3 -> Goal (End)
// 4 -> Start (Begin)
// 5 -> Checkpoint

bool Level::IsWall(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 0;
}
bool Level::IsPath(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 1;
}
bool Level::IsLava(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 2;
}
bool Level::IsGoal(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 3;
}
bool Level::IsStart(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 4;
}
bool Level::IsCheckpoint(const Tile& tile) const {
	auto [col, row] = tile;
	return Map[row][col] == 5;
}
bool Level::IsInbounds(const Tile& tile) const {
	auto [col, row] = tile;
	return (col < Width) && (row < Height);
}

}