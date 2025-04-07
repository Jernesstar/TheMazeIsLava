
shared class Tile
{
    uint8 x, y;
}

class Level
{
    Entity Handle;

    [Tilemap Width]
    uint32 Width;

    [Tilemap Height]
    uint32 Height;

    [Tilemap Data]
    List<uint8> Map;

    Level(Entity entity)
    {
        Handle = entity;
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
    bool IsCheckpoint(const Tile& tile) const {
        return Map[tile.y * Height + tile.x] == 5;
    }
    bool IsInbounds(const Tile& tile) const {
        return (tile.x < Width) && (tile.y < Height);
    }
}
