class PlayScreen : IScreen
{
    void OnLoad()
    {

    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        auto& state = HomeScreen.GetState();
        auto& level = GameState::GetLevel();

        level.OnUpdate(ts);

        if(level.GameOver)
            UIPage.PushLayer("GameOver");
        else if(level.Complete) {
            UIPage.PushLayer("LevelComplete");

            if(GameState::SelectedLevel == GameState::MaxLevel)
                GameState::MaxLevel++;
        }
        else if(state[Key::Return]) {
            state[Key::Return] = false;
            level.Paused = true;
            UIPage.PushLayer("Pause");
        }
    }

}