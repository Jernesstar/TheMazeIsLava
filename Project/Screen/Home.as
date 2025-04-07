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
        if(KeyPressed(Key::Return))
            App.SwitchScreen("Level");
    }
}