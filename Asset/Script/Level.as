
shared class Tile
{
    uint8 x, y;
}

shared class Level : IEntityController
{
    Entity Handle;

    [EditorField] uint32 Width;
    [EditorField] uint32 Height;

    [Tilemap]
    [EditorField] array<uint32> Map;

    bool Paused = false;
    bool GameOver = false;
    bool Complete = false;

    Level(Entity entity)
    {
        Handle = entity;
    }

    void OnStart()
    {

    }

    void OnUpdate(float ts)
    {
        // Propagate lava
    }

    void OnKeyEvent(KeyEvent@ event)
    {

    }

    void OnMouseEvent(MouseEvent@ event)
    {

    }

    void OnPhysicsEvent(PhysicsEvent@ event)
    {

    }

    void OnGameEvent(GameEvent@ event)
    {

    }

    bool IsWall(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 0;
    }
    bool IsPath(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 1;
    }
    bool IsLava(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 2;
    }
    bool IsGoal(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 3;
    }
    bool IsStart(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 4;
    }
    bool IsDoor(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 5;
    }
    bool IsCheckpoint(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 5;
    }
    bool IsInbounds(const Tile& tile) const {
        return (tile.x < Width) && (tile.y < Height);
    }
}
