
class IsometricCamera : IEntityController
{
    Entity Handle;

    [EditorField] float R;

    // CameraController Controller;

    IsometricCamera(Entity handle)
    {
        Handle = handle;
    }

    void OnStart()
    {
        CameraComponent@ cc = Handle.SetCameraComponent();
        // Controller.SetCamera(cc);

        cc.Position = R * sin(radians(Vec3(45.0f, 35.264f, 45.0f)));
        cc.Direction = -normalize(cc.Position);
        cc.Width = uint32(480.0f * (2.0f / R));
        cc.Height = uint32(270.0f * (2.0f / R));
    }

    void OnUpdate(float ts)
    {
        // Controller.Update(ts);

        CameraComponent@ cc = Handle.SetCameraComponent();

        if(Input::KeyPressed(Key::Up))
            cc.Position += Vec3(0.0f, 0.005f * ts, 0.0f);
        if(Input::KeyPressed(Key::Down))
            cc.Position -= Vec3(0.0f, 0.005f * ts, 0.0f);
        if(Input::KeyPressed(Key::Left))
            cc.Position -= Vec3(0.005f * ts, 0.0f, 0.0f);
        if(Input::KeyPressed(Key::Right))
            cc.Position += Vec3(0.005f * ts, 0.0f, 0.0f);
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
