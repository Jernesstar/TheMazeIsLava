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
        print(levelStr);
        App.LoadScene(levelStr);
        print("Here");

        Entity entity = Scene.FindEntity("LevelData");
        if(!entity.IsValid()) {
            print("Error: No LevelData");
            return;
        }
        else
            print("Found");

        @LevelData = cast<Level>(entity.SetScriptComponent().Instance);
        print("Paused: " + LevelData.Paused);
        print("OnLoad");
    }

    void OnClose()
    {
        print("OnClose");
    }

    void OnUpdate(float ts)
    {

    }
}