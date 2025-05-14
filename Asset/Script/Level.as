
shared class Tile
{
    uint8 x, y;
}

shared class GameOverEvent : GameEvent
{
    string GetID() const { return "GameOver"; }
}

shared class Level : IEntityController
{
    Entity Handle;

    [EditorField] uint32 Width;
    [EditorField] uint32 Height;

    [Tilemap]
    [EditorField] array<uint32> Map;

    [EditorField] Asset WallAsset;
    [EditorField] Asset PathAsset;
    [EditorField] Asset StairAsset;

    bool Paused = false;
    bool GameOver = false;
    bool Complete = false;

    Level(Entity entity)
    {
        Handle = entity;
    }

    void OnStart()
    {
        for(uint32 y = 0; y < Height; y++) {
            for(uint32 x = 0; x < Width; x++) {
                Tile tile;
                tile.x = x;
                tile.y = y;
                Entity newEntity;

                if(IsWall(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Wall");
                }
                else if (IsStart(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Start");

                }
                else if (IsPath(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Path");
                    newEntity = Scene.NewEntity();
                    TransformComponent@ tc = newEntity.AddTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;
                    // tc.Translation.y = 1;
                    tc.Scale = Vec3(0.8f);

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshAsset = PathAsset;
                }
                else if (IsCode(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Code");
                    
                }
                else if (IsLava(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Lava");

                }
                else if (IsGoal(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Goal");

                    newEntity = Scene.NewEntity();
                    TransformComponent@ tc = newEntity.AddTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshAsset = StairAsset;
                }
                else if (IsCheckpoint(tile)) {
                    // newEntity = Scene.NewEntityFromPrefab("Checkpoint");

                }
            }
        }
    }

    void OnUpdate(float ts)
    {
        // Propagate lava
    }

    void OnKeyEvent(KeyEvent@ event)
    {
        KeyPressedEvent@ e = cast<KeyPressedEvent>(event);
        if(@e == null)
            return;

        if (e.Key == Key::Enter) {
            Paused = !Paused;
            if(Paused)
                UIPage.SetLayer("Pause");
            else
                UIPage.SetLayer("Root");
        }
    }

    void OnMouseEvent(MouseEvent@ event)
    {

    }

    void OnPhysicsEvent(PhysicsEvent@ event)
    {

    }

    void OnGameEvent(GameEvent@ event)
    {
        if(event.GetID() == "GameOver") {
            GameOver = true;
            UIPage.SetLayer("GameOver");
        }
        else if (event.GetID() == "LevelComplete") {
            Complete = true;
            UIPage.SetLayer("LevelComplete");
        }
    }

    bool IsWall(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 0;
    }
    bool IsStart(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 1;
    }
    bool IsPath(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 2;
    }
    bool IsCode(const Tile& tile) {
        return Map[tile.y * Height + tile.x] == 3;
    }
    bool IsLava(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 4;
    }
    bool IsGoal(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 5;
    }
    bool IsCheckpoint(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 6;
    }
    bool IsInbounds(const Tile& tile) const {
        return (tile.x < Width) && (tile.y < Height);
    }
}
