#include "App/TheMazeIsLava.as"

class LevelButton : IUIObject
{
    string ID;

    LevelButton(const string &id)
    {
        ID = id;
    }

    void OnClick()
    {
        TheMazeIsLava @app = cast<TheMazeIsLava>(ScriptClass);

        // Button_
        string subStr = ID.substr(6);
        app.GameState.SelectedLevel = parseInt(subStr);
    }

    void OnHover()
    {

    }

    void OnMouseUp()
    {

    }

    void OnMouseDown()
    {

    }

    void OnUpdate(float ts)
    {

    }
}