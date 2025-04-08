class LevelScreen : IScreen
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
        if(game.GameState.SelectedLevel == 0)
            return;

        App.SwitchScreen("Play");
    }
}