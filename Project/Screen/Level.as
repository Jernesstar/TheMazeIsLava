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
        if(GameState.SelectedLevel == 0)
            return;

        App.SwitchScreen("Play");
    }

}