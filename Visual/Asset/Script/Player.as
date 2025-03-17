
class Player : IEntity
{
    Entity Handle;

    Player(Entity entity)
    {
        Handle = entity;
    }

    void OnUpdate(float ts)
    {
        if(MousePressed(Mouse::Left))
            return;
        if(!Handle.HasTransformComponent())
            return;

        TransformComponent@ tc = Handle.GetTransformComponent();
        int dx = (KeyPressed(Key::Right) || KeyPressed(Key::D))
                -(KeyPressed(Key::Left)  || KeyPressed(Key::A));
        int dz = (KeyPressed(Key::Down)  || KeyPressed(Key::S))
                -(KeyPressed(Key::Up)    || KeyPressed(Key::W));

        Vec3 moveDir = { dx, 0.0f, dz };
        float speed = 0.03f;
        if(dx || dz)
            tc.Translation += normalize(moveDir) * speed * ts;
    }
}
