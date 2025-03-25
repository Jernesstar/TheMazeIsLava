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
        ref ScreenState state = GetState();
        if(state[Key::Return])
        {
            state[Key::Return] = false;
            App.SwitchScreen("Level");
        }
    }

}