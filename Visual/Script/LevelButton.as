
class LevelButton : IUIObject
{
    string ID;

    LevelButton(const string &id)
    {
        ID = id;
    }

    void OnClick()
    {
        auto subStr = m_ID.substr(5);
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