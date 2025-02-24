
class LevelButton : IUIObject
{
    void OnClick()
    {
        auto subStr = m_ID.substr(5);
        s_GameState.SelectedLevel = parseInt(subStr);
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