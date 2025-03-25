
class IsometricCamera : IEntityController
{
    Entity Handle;
    float R;

    IsometricCamera(Entity handle)
    {
        Handle = handle;
        CameraComponent@ cc = Handle.SetCameraComponent();

        cc.Position =
            R * Vec3
                {
                    sin(radians(45.0f)),
                    sin(radians(35.264f)),
                    sin(radians(45.0f))
                };
        cc.Direction = -normalize(Position);

        cc.ViewportWidth = 480 * (2.0f / R);
        cc.ViewportHeight = 270 * (2.0f / R);
    }

    void OnUpdate()
    {

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
