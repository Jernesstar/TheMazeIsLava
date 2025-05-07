
class Player : IEntityController
{
    Entity Handle;

    Player(Entity entity)
    {
        Handle = entity;
    }

    void OnStart()
    {

    }

    void OnUpdate(float ts)
    {
        if(Input::MousePressed(Mouse::Left))
            return;
        if(!Handle.HasTransformComponent())
            return;

        // TransformComponent@ tc = Handle.SetTransformComponent();
        // int dx = int(Input::KeyPressed(Key::Right) || Input::KeyPressed(Key::D))
        //         - int(Input::KeyPressed(Key::Left)  || Input::KeyPressed(Key::A));
        // int dz = int(Input::KeyPressed(Key::Down)  || Input::KeyPressed(Key::S))
        //         - int(Input::KeyPressed(Key::Up)    || Input::KeyPressed(Key::W));

        // Vec3 moveDir = { dx, 0.0f, dz };
        // float speed = 0.03f;
        // if(dx != 0 || dz != 0)
        //     tc.Translation += normalize(moveDir) * speed * ts;
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
