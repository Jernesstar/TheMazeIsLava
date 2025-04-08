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
        TheMazeIsLava@ game = cast<TheMazeIsLava>(ScriptApp);
        Entity entity = Scene.FindEntity("LevelData");
        Level@ level = cast<Level>(entity.GetScriptComponent().Instance);

        if(level.GameOver)
            UIPage.PushLayer("GameOver");
        else if (level.Complete)
            UIPage.PushLayer("LevelComplete");
        else if (KeyPressed(Key::Return)) {
            level.Paused = !level.Paused;
            if(level.Paused)
                UIPage.PushLayer("Pause");
        }
    }

}