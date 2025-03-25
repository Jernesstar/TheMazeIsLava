#include "../../Project/App/TheMazeIsLava.as"

class LevelButton : IUIController
{
    string ID;
    uint32 Level;

    LevelButton(const string &id)
    {
        ID = id;
    }

    void OnUpdate(float ts)
    {

    }

    void OnClick()
    {
        TheMazeIsLava@ app = cast<TheMazeIsLava>(ScriptClass);
        app.GameState.SelectedLevel = Level;
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
}