
class LevelButton : IUIObject
{
    string ID;

    LevelButton(const string &id)
    {
        ID = id;
    }

    void OnClick()
    {
        // Button__
        auto subStr = ID.substr(5);
        ScriptApp.GameState.SelectedLevel = parseInt(subStr);
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