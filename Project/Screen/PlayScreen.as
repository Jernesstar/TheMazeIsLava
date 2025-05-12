#include "../App/TheMazeIsLava.as"

#include "../../Asset/Script/Level.as"

class PlayScreen : IScreen
{
    TheMazeIsLava@ Game;
    Level@ LevelData;

    void OnLoad()
    {
       @Game = cast<TheMazeIsLava>(ScriptApp);

        string levelStr = "Level" + Game.GameState.SelectedLevel;
        print(levelStr);
        App.LoadScene(levelStr);

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
        if (LevelData.GameOver)
            UIPage.PushLayer("GameOver");
        else if (LevelData.Complete)
            UIPage.PushLayer("LevelComplete");
        else if (Input::KeyPressed(Key::Enter)) {
            LevelData.Paused = !LevelData.Paused;
            if(LevelData.Paused)
                UIPage.PushLayer("Pause");
            else
                UIPage.PopLayer();
        }
    }

}