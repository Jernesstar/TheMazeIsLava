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
        // App.LoadScene(levelStr);

        // Entity entity = Scene.FindEntity("LevelData");
        // LevelData = cast<Level>(entity.GetScriptComponent().Instance);
        print("OnLoad");
    }

    void OnClose()
    {

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