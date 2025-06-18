
class Tile
{
    uint32 x, y;

    Tile() { }

    Tile(uint32 x, uint32 y)
    {
        this.x = x;
        this.y = y;
    }
}

class GameOverEvent : GameEvent
{
    string GetID() const { return "GameOver"; }
}

class Level : IEntityController
{
    Entity Handle;

    [EditorField]
    GridSet Grid;

    bool Paused = false;
    bool GameOver = false;
    bool Complete = false;

    Level(Entity entity)
    {
        Handle = entity;
    }

    void OnStart()
    {
        Asset WallAsset = AssetManager.GetNamedAsset("Wall");
        Asset TorchAsset = AssetManager.GetNamedAsset("Torch");
        Asset StairAsset = AssetManager.GetNamedAsset("Stairs");
        Asset PlayerAsset = AssetManager.GetNamedAsset("Player");
        if(!WallAsset.IsValid or !TorchAsset.IsValid
        or !StairAsset.IsValid or !PlayerAsset.IsValid)
        {
            print("Could not find all needed assets");
            return;
        }

        for(uint32 y = 0; y < Grid.Height; y++)
        {
            for(uint32 x = 0; x < Grid.Width; x++)
            {
                Tile tile;
                tile.x = x;
                tile.y = y;
                Entity newEntity;

                if(IsWall(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Wall");

                    newEntity = Scene.NewEntity();
                    TransformComponent@ tc = newEntity.AddTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;
                    // tc.Translation.y = 1;
                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshAsset = WallAsset;

                    auto back = Tile(x, y - 1);
                    auto left = Tile(x - 1, y);
                    auto right = Tile(x + 1, y);
                    auto front = Tile(x, y + 1);
                    Entity light;
                    if(IsInbounds(front) and IsPath(front))
                    {
                        light = Scene.NewEntity();
                        TransformComponent@ tc2 = light.AddTransformComponent();
                        tc2.Translation.x = x;
                        tc2.Translation.z = y;
                        // tc.Translation.y = 1;
                        tc2.Scale = Vec3(0.5f);

                        tc2.Rotation.x = radians(20.0f);
                        tc2.Translation.z += 0.5f;

                        // ParticleEmitterComponent@ pc = light.AddParticleEmitterComponent();

                    }

                    if(light.IsValid)
                    {
                        MeshComponent@ mc2 = light.AddMeshComponent();
                        mc2.MeshAsset = TorchAsset;
                    }
                }
                else if (IsStart(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Start");

                    newEntity = Scene.NewEntity();
                    TransformComponent@ tc = newEntity.AddTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;
                    // tc.Translation.y = 1;
                    // MeshComponent@ mc = newEntity.AddMeshComponent();
                    // mc.MeshAsset = PlayerAsset;
                }
                else if (IsPath(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Path");

                }
                else if (IsCode(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Code");
                    
                }
                else if (IsLava(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Lava");

                }
                else if (IsGoal(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Goal");

                    newEntity = Scene.NewEntity();
                    TransformComponent@ tc = newEntity.AddTransformComponent();
                    tc.Translation.x = x;
                    tc.Translation.z = y;
                    tc.Scale = Vec3(0.5f);

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshAsset = StairAsset;
                }
                else if (IsCheckpoint(tile))
                {
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

        if (e.Key == Key::Enter)
        {
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
        if(event.GetID() == "GameOver")
        {
            GameOver = true;
            UIPage.SetLayer("GameOver");
        }
        else if (event.GetID() == "LevelComplete")
        {
            Complete = true;
            UIPage.SetLayer("LevelComplete");
        }
    }

    bool IsWall(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 1;
    }
    bool IsStart(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 2;
    }
    bool IsPath(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 3;
    }
    bool IsCode(const Tile& tile) {
        return Grid.At(tile.x, tile.y) == 4;
    }
    bool IsLava(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 5;
    }
    bool IsGoal(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 6;
    }
    bool IsCheckpoint(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 7;
    }
    bool IsInbounds(const Tile& tile) const
    {
        return (tile.x < Grid.Width) && (tile.y < Grid.Height);
    }
}
