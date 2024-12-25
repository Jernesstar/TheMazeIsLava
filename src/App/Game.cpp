#include "Game.h"

#include <VolcaniCore/Core/Input.h>
#include <VolcaniCore/Core/Assert.h>
#include <VolcaniCore/Event/Events.h>
#include <VolcaniCore/Graphics/RendererAPI.h>

#include <Magma/ECS/EntityBuilder.h>

#include <Lava/UIBrowser.h>

#include <Class/Player.h>

#include <Common/GameState.h>
#include <Common/IsometricCamera.h>

using namespace Magma::ECS;

namespace TheMazeIsLava {

void Game::OnLoad() {
	VOLCANICORE_LOG_INFO("We made it this far, right?");
	GameState::Reset();
	// Lava::UIBrowser::SetPage("Home");
}

void Game::OnClose() {
	GameState::Save();
}

void Game::OnUpdate(TimeStep ts) {

}

void Game::LoadScreens() {
	HomeScreen.OnUpdate =
		[&](TimeStep ts)
		{
 			auto& state = HomeScreen.GetState();

			if(state[Key::Return]) {
				state[Key::Return] = false;
				m_CurrentScreen = &LevelScreen;
				// GameState::SelectedLevel = 1;
				m_CurrentScreen->OnLoad();
			}
		};

	LevelScreen.OnUpdate =
		[&](TimeStep _)
		{
			// TODO(Implement): Staircase like level selection
			// DrawLevelVisualizer();

			if(GameState::SelectedLevel == 0)
				return;

			m_CurrentScreen = &PlayScreen;
			m_CurrentScreen->OnLoad();
		};

	PlayScreen.OnLoad =
		[&]()
		{
			auto& currLevel = GameState::GetLevel();
			currLevel.Load();
			auto scene = currLevel.GetScene();
			Renderer.SetContext(scene.get());

			auto camera = CreateRef<IsometricCamera>(100.0f);
			auto& controller = Renderer.GetCameraController();
			controller.SetControls(
				MovementControls(
					ControlMap
					{
						{ Control::Up,   Key::W },
						{ Control::Down, Key::S },
						{ Control::Forward,  Key::Invalid },
						{ Control::Backward, Key::Invalid },
					})
				);
			controller.TranslationSpeed = 5.0f;
			controller.RotationSpeed = 0.0f;
			controller.SetCamera(camera);
			camera->SetDistance(60.0f);

			scene->EntityWorld.AddEntity("MainCamera")
			.Add<CameraComponent>(camera);

			auto [x, y] = currLevel.PlayerStart;
			Player player(scene->EntityWorld);
			player.Get<TransformComponent>() =
				Transform
				{
					.Translation = { x, 5.0f, y }
				};

			// TODO(Implement): Collision with group
			// PhysicsSystem::RegisterForCollisionDetection(player, m_LavaGroup);
		};

	PlayScreen.OnUpdate =
		[&](TimeStep ts)
		{
			auto& state = HomeScreen.GetState();
			auto& level = GameState::GetLevel();

			level.OnUpdate(ts);
			level.OnRender();

			if(level.GameOver)
				m_CurrentScreen = &OverScreen;
			else if(level.Complete) {
				m_CurrentScreen = &LevelScreen;

				if(GameState::SelectedLevel == GameState::MaxLevel) {
					GameState::MaxLevel++;
					m_CurrentScreen->OnLoad();
				}
			}
			else if(state[Key::Return]) {
				state[Key::Return] = false;
				level.Paused = true;
				m_CurrentScreen = &PauseScreen;
				m_CurrentScreen->OnLoad();
			}
		};

	// TODO(Fix): Have Pause UI be part of the PlayScreen
	PauseScreen.OnUpdate =
		[&](TimeStep _)
		{
			auto& state = HomeScreen.GetState();
			auto& level = GameState::GetLevel();

			if(state[Key::Return]) {
				state[Key::Return] = false;
				level.Paused = false;
				m_CurrentScreen = &PlayScreen;
				m_CurrentScreen->OnLoad();
			}
		};

	OverScreen.OnUpdate =
		[&](TimeStep _)
		{
			auto& state = HomeScreen.GetState();

			if(state[Key::Return]) {
				state[Key::Return] = false;
				m_CurrentScreen = &PlayScreen;
				m_CurrentScreen->OnLoad();
			}
		};
}

}