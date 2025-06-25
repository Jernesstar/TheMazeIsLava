
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
        TransformComponent@ tc = Handle.SetTransformComponent();

        if(Input::KeyPressed(Key::Left))
            tc.Translation.x -= 0.005f * ts;
        else if (Input::KeyPressed(Key::Right))
            tc.Translation.x += 0.005f * ts;
        else if (Input::KeyPressed(Key::Up))
            tc.Translation.z -= 0.005f * ts;
        else if (Input::KeyPressed(Key::Down))
            tc.Translation.z += 0.005f * ts;
        else if (Input::KeyPressed(Key::Q))
            tc.Translation.y += 0.005f * ts;
        else if (Input::KeyPressed(Key::E))
            tc.Translation.y -= 0.005f * ts;
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
