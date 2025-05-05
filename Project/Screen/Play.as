#include "../Script/Level.as"

class PlayScreen : IScreen
{
    Level@ LevelData;

    void OnLoad()
    {
        Entity entity = Scene.FindEntity("LevelData");
        LevelData = cast<Level>(entity.GetScriptComponent().Instance);
    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        TheMazeIsLava@ game = cast<TheMazeIsLava>(ScriptApp);

        if (LevelData.GameOver)
            UIPage.PushLayer("GameOver");
        else if (LevelData.Complete)
            UIPage.PushLayer("LevelComplete");
        else if (KeyPressed(Key::Return)) {
            LevelData.Paused = !LevelData.Paused;
            if(LevelData.Paused)
                UIPage.PushLayer("Pause");
            else
                UIPage.PopLayer();
        }
    }

}