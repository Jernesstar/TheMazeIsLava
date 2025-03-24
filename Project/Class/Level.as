
shared class Tile
{
    uint8 x, y;
}

shared class Level
{
    uint32 Width, Height;
    List<uint8> Map;

    Level()
    {

    }

    void Load(uint32 level)
    {
        BinaryFile file("Asset/save/level_" + level + ".bin");
        file.Read(Width);
        file.Read(Height);
        file.Read(Map);

        Entity cameraEntity = Scene.AddEntity("MainCamera");
        cameraEntity.AddCameraComponent(CameraType::Ortho);
        cameraEntity.AddScriptComponent(404, "IsometricCamera");
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
