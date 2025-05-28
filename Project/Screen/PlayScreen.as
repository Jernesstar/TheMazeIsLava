#include "../App/TheMazeIsLava.as"

#include "../../Asset/Script/Level.as"

class PlayScreen : IScreen
{
    TheMazeIsLava@ Game;
    Level@ LevelData;

    void OnLoad()
    {
       @Game = cast<TheMazeIsLava>(ScriptApp);

#if EDITOR
        Game.GameState.SelectedLevel = 1;
#endif

        string levelStr = "Level" + Game.GameState.SelectedLevel;
        // print(levelStr);
        // App.LoadScene(levelStr);
        // print("Here");
    }

    void OnClose()
    {
        print("OnClose");
    }

    void OnUpdate(float ts)
    {

    }
}