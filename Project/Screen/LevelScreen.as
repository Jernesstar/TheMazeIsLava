class HomeScreen : IScreen
{
    void OnLoad()
    {

    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        if(s_GameState.SelectedLevel == 0)
            return;

        App.SetScreen(PlayScreen);
    }

}