#include "../App/TheMazeIsLava.as"

class PlayScreen : IScreen
{
    TheMazeIsLava@ Game;

    void OnLoad()
    {
       @Game = cast<TheMazeIsLava>(ScriptApp);

#if EDITOR
        Game.GameState.SelectedLevel = 1;
#endif
        string levelStr = "Level" + Game.GameState.SelectedLevel;
        App.LoadScene(levelStr);
    }

    void OnClose()
    {
        print("OnClose");
    }

    void OnUpdate(float ts)
    {

    }
}