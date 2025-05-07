#include "../../Project/App/TheMazeIsLava.as"

class LevelButton : IUIController
{
    string ID;

    [EditorField] uint32 Level;

    LevelButton(string id)
    {
        ID = id;
    }

    void OnUpdate(float ts)
    {

    }

    void OnClick()
    {
        // print("Level: " + Level);

        TheMazeIsLava@ app = cast<TheMazeIsLava>(ScriptApp);
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