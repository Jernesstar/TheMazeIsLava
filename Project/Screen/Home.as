class HomeScreen : IScreen
{
    void OnLoad()
    {
        App.LoadUI("HomeUI");
    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        if(KeyPressed(Key::Return))
            App.SwitchScreen("Level");
    }
}