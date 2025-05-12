
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

        cc.Position = sin(radians(Vec3(45.0f, 35.264f, 45.0f)));
        cc.Direction = -normalize(cc.Position);
        cc.Width = uint32(480.0f * (2.0f / R));
        cc.Height = uint32(270.0f * (2.0f / R));
    }

    void OnUpdate(float ts)
    {
        CameraComponent@ cc = Handle.SetCameraComponent();

        if(Input::KeyPressed(Key::Up))
            cc.Position += Vec3(0.0f, 0.00005f, 0.0f);
        if(Input::KeyPressed(Key::Down))
            cc.Position -= Vec3(0.0f, 0.00005f, 0.0f);
        if(Input::KeyPressed(Key::Left))
            cc.Position -= Vec3(0.00005f, 0.0f, 0.0f);
        if(Input::KeyPressed(Key::Right))
            cc.Position += Vec3(0.00005f, 0.0f, 0.0f);
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
