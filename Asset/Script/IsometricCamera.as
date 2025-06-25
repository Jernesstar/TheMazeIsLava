
class IsometricCamera : IEntityController
{
    Entity Handle;

    [EditorField] float R;

    IsometricCamera(Entity handle)
    {
        Handle = handle;
    }

    void OnStart()
    {
        CameraComponent@ cc = Handle.SetCameraComponent();

        cc.Position = R * sin(radians(Vec3(45.0f, 35.264f, 45.0f)));
        cc.Direction = -normalize(cc.Position);
        cc.Width = uint32(480.0f * (2.0f / R));
        cc.Height = uint32(270.0f * (2.0f / R));
    }

    void OnUpdate(float ts)
    {
        CameraComponent@ cc = Handle.SetCameraComponent();

        
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
}
