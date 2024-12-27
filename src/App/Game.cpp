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
	GameState::Reset();
	Lava::UIBrowser::SetPage("Home");
}

void Game::OnClose() {
	GameState::Save();
}

void Game::OnUpdate(TimeStep ts) {

}

void Game::SetScreen(Screen& screen) {
	m_CurrentScreen = &screen;
	m_CurrentScreen->OnLoad();
}

void Game::LoadScreens() {
	HomeScreen.OnUpdate =
		[&](TimeStep ts)
		{
 			auto& state = HomeScreen.GetState();

			if(state[Key::Return]) {
				state[Key::Return] = false;
				SetScreen(LevelScreen);
			}
		};

	LevelScreen.OnLoad =
		[]()
		{
			Lava::UIBrowser::SetPage("Level");
		};

	LevelScreen.OnUpdate =
		[&](TimeStep _)
		{
			// TODO(Implement): Staircase like level selection
			// DrawLevelVisualizer();

			if(GameState::SelectedLevel == 0)
				return;

			SetScreen(PlayScreen);
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

			// TODO(Implement): Collision with group
			// PhysicsSystem::RegisterForCollisionDetection(player, m_LavaGroup);
		};

	PlayScreen.OnUpdate =
		[&](TimeStep ts)
		{
			auto& state = HomeScreen.GetState();
			auto& level = GameState::GetLevel();

			level.OnUpdate(ts);
			Renderer.Update(ts);
			Renderer.Render();

			if(level.GameOver)
				SetScreen(OverScreen);
			else if(level.Complete) {
				SetScreen(LevelScreen);

				if(GameState::SelectedLevel == GameState::MaxLevel)
					GameState::MaxLevel++;
			}
			else if(state[Key::Return]) {
				state[Key::Return] = false;
				level.Paused = true;
				Lava::UIBrowser::SetPage("Pause");
			}
		};

	OverScreen.OnUpdate =
		[&](TimeStep _)
		{
			auto& state = OverScreen.GetState();

			if(state[Key::Return]) {
				state[Key::Return] = false;
				SetScreen(PlayScreen);
			}
			else if(state[Key::Escape]) {
				state[Key::Escape] = false;
				SetScreen(LevelScreen);
			}
		};
}

}