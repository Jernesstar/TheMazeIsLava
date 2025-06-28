
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
    array<Tile> LavaPoints;
    // Timer LavaTimer;

    Level(Entity entity)
    {
        Handle = entity;
    }

    void OnStart()
    {
        // LavaTimer = Timer(TimerType::Repeat, 2000); // 2 seconds
        // LavaTimer.SetCallback(LavaUpdate);

        Asset StartAsset = AssetManager.GetNamedAsset("StartMaterial");
        Asset WallAsset = AssetManager.GetNamedAsset("WallMaterial");
        Asset PathAsset = AssetManager.GetNamedAsset("PathMaterial");
        Asset TorchAsset = AssetManager.GetNamedAsset("Torch");
        Asset CodeAsset = AssetManager.GetNamedAsset("Code");
        // Asset DoorAsset = AssetManager.GetNamedAsset("Door");
        Asset DoorAsset = AssetManager.GetNamedAsset("DoorMaterial");
        Asset StairAsset = AssetManager.GetNamedAsset("Stairs");
        Asset LavaAsset = AssetManager.GetNamedAsset("LavaMaterial");
        // Asset CheckpointAsset = AssetManager.GetNamedAsset("Checkpoint");

        for(uint32 y = 0; y < Grid.Height; y++)
        {
            for(uint32 x = 0; x < Grid.Width; x++)
            {
                Tile tile;
                tile.x = x;
                tile.y = y;
                Entity newEntity;

                if(IsSpace(tile))
                    continue;

                newEntity = Scene.NewEntity();
                TransformComponent@ tc = newEntity.AddTransformComponent();
                tc.Translation.x = x;
                tc.Translation.z = y;

                if(IsStart(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Start");

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshSourceAsset = AssetManager.GetNativeAsset("Cube");
                    mc.MaterialAsset = StartAsset;

                    Entity entity = Scene.FindEntity("Player");
                    TransformComponent@ tr = entity.SetTransformComponent();
                    tr.Translation.x = tile.x;
                    tr.Translation.z = tile.y;
                }
                else if (IsWall(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Wall");

                    tc.Translation.y = 1;
                    // MeshComponent@ mc = newEntity.AddMeshComponent();
                    // mc.MeshSourceAsset = AssetManager.GetNativeAsset("Cube");
                    // mc.MaterialAsset = WallAsset;

                    // auto back = Tile(x, y - 1);
                    // auto left = Tile(x - 1, y);
                    // auto right = Tile(x + 1, y);
                    // auto front = Tile(x, y + 1);
                    // Entity light;
                    // if(IsInbounds(front) and IsPath(front))
                    // {
                    //     light = Scene.NewEntity();
                    //     TransformComponent@ tc2 = light.AddTransformComponent();
                    //     tc2.Translation.x = x;
                    //     tc2.Translation.z = y;
                    //     tc2.Scale = Vec3(0.5f);

                    //     tc2.Rotation.x = radians(20.0f);
                    //     tc2.Translation.z += 0.5f;

                    //     ParticleEmitterComponent@ pc = light.AddParticleEmitterComponent();
                    //     pc.Position = Vec3(tile.x, 0.7f, tile.y + 0.5f);
                    //     pc.MaxParticles = 50;
                    // }

                    // if(light.IsValid)
                    // {
                    //     MeshComponent@ mc2 = light.AddMeshComponent();
                    //     mc2.MeshSourceAsset = TorchAsset;
                    // }
                }
                else if (IsPath(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Path");

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshSourceAsset = AssetManager.GetNativeAsset("Cube");
                    mc.MaterialAsset = PathAsset;
                }
                else if (IsCode(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Code");
                    tc.Translation.y = 1;
                    tc.Scale = Vec3(0.0011);

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshSourceAsset = CodeAsset;
                }
                else if (IsLockedDoor(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("LockedDoor");
                    // tc.Scale = Vec3(0.5f);
                    tc.Translation.y = 1;

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    // mc.MeshSourceAsset = DoorAsset;
                    mc.MeshSourceAsset = AssetManager.GetNativeAsset("Cube");
                    mc.MaterialAsset = DoorAsset;
                }
                else if (IsGoal(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Goal");

                    // tc.Scale = Vec3(0.1f);
                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshSourceAsset = StairAsset;
                }
                else if (IsLava(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Lava");
    
                    // FluidMeshComponent@ fc = newEntity.AddFluidMeshComponent();
                    // fc.MaterialAsset = LavaAsset;

                    tc.Translation.y = 1;

                    MeshComponent@ mc = newEntity.AddMeshComponent();
                    mc.MeshSourceAsset = AssetManager.GetNativeAsset("Cube");
                    mc.MaterialAsset = LavaAsset;

                    // LavaPoints.insertLast(tile);
                }
                else if (IsCheckpoint(tile))
                {
                    // newEntity = Scene.NewEntityFromPrefab("Checkpoint");

                    // MeshComponent@ mc = newEntity.AddMeshComponent();
                    // mc.MeshSourceAsset = CheckpointAsset;
                }
            }
        }
    }

    void OnUpdate(float ts)
    {
        // LavaTimer.Tick(ts);
    }

    void LavaUpdate(float ts)
    {
        array<Tile> lava = LavaPoints;
        for(uint32 i = 0; i < LavaPoints.length(); i++) {
            
        }
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

    bool IsSpace(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 0;
    }
    bool IsStart(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 1;
    }
    bool IsWall(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 2;
    }
    bool IsPath(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 3;
    }
    bool IsCode(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 4;
    }
    bool IsLockedDoor(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 5;
    }
    bool IsGoal(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 6;
    }
    bool IsLava(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 7;
    }
    bool IsCheckpoint(const Tile& tile) const
    {
        return Grid.At(tile.x, tile.y) == 8;
    }
    bool IsInbounds(const Tile& tile) const
    {
        return (tile.x < Grid.Width) && (tile.y < Grid.Height);
    }
}
