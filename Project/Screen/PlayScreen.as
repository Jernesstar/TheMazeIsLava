class HomeScreen : IScreen
{
    void OnLoad()
    {
        auto& currLevel = GameState::GetLevel();
        currLevel.Load();
        auto scene = currLevel.GetScene();

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
        camera.SetDistance(60.0f);

        scene.EntityWorld.AddEntity("MainCamera")
        .Add<CameraComponent>(camera);

        // TODO(Implement): Collision with group
        // PhysicsSystem::RegisterForCollisionDetection(player, m_LavaGroup);
    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        auto& state = HomeScreen.GetState();
        auto& level = GameState::GetLevel();

        level.OnUpdate(ts);
        Renderer.Update(ts);
        Renderer.Render();

        if(level.GameOver)
            App.SetScreen("OverScreen");
        else if(level.Complete) {
            App.SetScreen("LevelScreen");

            if(GameState::SelectedLevel == GameState::MaxLevel)
                GameState::MaxLevel++;
        }
        else if(state[Key::Return]) {
            state[Key::Return] = false;
            level.Paused = true;
            App.PushScreen("Pause");
        }
    }

}