
class HomeScreen : IScreen
{
    void OnLoad()
    {
        // App.LoadUI("HomeUI");
    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        if(Input::KeyPressed(Key::Enter))
            App.SwitchScreen("Level");
    }
}