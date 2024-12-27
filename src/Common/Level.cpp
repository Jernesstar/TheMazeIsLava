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
	: Name(name), Width(map[0].size()), Height(map.size()), Map(map) { }

void Level::OnUpdate(TimeStep ts) {
	PropagateLava(ts);

	if(m_Scene)
		m_Scene->OnUpdate(ts);
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

			else if(IsStart(tile)) {
				PlayerStart = tile;

				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y }
					})
				.Add<MeshComponent>("Wall")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}

			if(IsWall(tile)) {
				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y }
					})
				.Add<MeshComponent>("Wall")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
			else if(IsPath(tile)) {
				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 0.0f, y }
					})
				.Add<MeshComponent>("Path")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				// .Add<MeshComponent>(PickPathMesh(tile))
				.Finalize();
			}
			else if(IsLava(tile)) {
				LavaPoints.push_back(tile);

				world.BuildEntity()
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y }
					})
				.Add<MeshComponent>("Lava")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
			else if(IsGoal(tile)) {
				Goal = tile;

				world.BuildEntity("Goal")
				.Add<TransformComponent>(
					Transform
					{
						.Translation = { x, 1.0f, y },
						.Scale = glm::vec3(0.5)
					})
				.Add<MeshComponent>("Goal")
				// .Add<RigidBodyComponent>(RigidBody::Type::Static)
				.Finalize();
			}
		});

	auto [x, y] = PlayerStart;
	Player player(scene->EntityWorld);
	player.Get<TransformComponent>() =
		Transform
		{
			.Translation = { x, 5.0f, y }
		};
}

void Level::PropagateLava(TimeStep ts) {
	if((m_LavaTick += ts) >= 3.0f) // 3 Seconds
		return;

	m_LavaTick = 0;
	List<Tile> newPoints;
	for(auto& point : LavaPoints) {
		uint32_t x = point.x, y = point.y;
		Tile neighbors[] =
			{ { x - 1, y }, { x + 1, y }, { x, y - 1 }, { x, y + 1 } };

		for(auto n : neighbors) {
			if(!IsInbounds(n) || !IsPath(n))
				continue;
			
			m_Scene->EntityWorld
			.BuildEntity()
			.Add<TransformComponent>(
				Transform
				{
					.Translation = { n.x, 1.0f, n.y }
				})
			.Add<MeshComponent>("Lava")
			// .Add<RigidBodyComponent>(RigidBody::Type::Static)
			.Finalize();

			newPoints.push_back(n);
		}
	}

	LavaPoints = newPoints;
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