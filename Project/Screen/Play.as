#include "../Script/Level.as"

class PlayScreen : IScreen
{
    void OnLoad()
    {
        Level@ level = cast<Level>(entity.GetScriptComponent().Instance);

        for(uint32 y = 0; y < level.Height; y++) {
            for(uint32 x = 0; x < level.Width; x++) {
                Tile tile;
                tile.x = x;
                tile.y = y;
                Entity newEntity;

                if(level.IsWall(tile)) {
                    newEntity = Scene.CreateFromPrefab("Wall");
                    TransformComponent@ tc = newEntity.GetTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;
                }
                if(level.IsPath(tile)) {
                    newEntity = Scene.CreateFromPrefab("Path");

                }
                if(level.IsLava(tile)) {
                    newEntity = Scene.CreateFromPrefab("Lava");

                }
                if(level.IsGoal(tile)) {
                    newEntity = Scene.CreateFromPrefab("Goal");

                }
                if(level.IsStart(tile)) {
                    newEntity = Scene.CreateFromPrefab("Start");

                }
                if(level.IsDoor(tile)) {
                    newEntity = Scene.CreateFromPrefab("Door");

                }
                if(level.IsCheckpoint(tile)) {
                    newEntity = Scene.CreateFromPrefab("Checkpoint");

                }
            }
        }
    }

    void OnClose()
    {

    }

    void OnUpdate(float ts)
    {
        TheMazeIsLava@ game = cast<TheMazeIsLava>(ScriptApp);
        Entity entity = Scene.FindEntity("LevelData");
        Level@ level = cast<Level>(entity.GetScriptComponent().Instance);

        if (level.GameOver)
            UIPage.PushLayer("GameOver");
        else if (level.Complete)
            UIPage.PushLayer("LevelComplete");
        else if (KeyPressed(Key::Return)) {
            level.Paused = !level.Paused;
            if(level.Paused)
                UIPage.PushLayer("Pause");
            else
                UIPage.PopLayer();
        }
    }

}