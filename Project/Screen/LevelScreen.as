#include "../App/TheMazeIsLava.as"

class LevelScreen : IScreen
{
    void OnLoad()
    {

    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        // Staircase-like level select

        TheMazeIsLava@ game = cast<TheMazeIsLava>(ScriptApp);
        if(game.GameState.SelectedLevel == 0)
            return;

        App.SwitchScreen("PlayScreen");
    }
}