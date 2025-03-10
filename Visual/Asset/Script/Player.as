
class Player : IEntity
{
    Entity Handle;

    Player(Entity entity)
    {
        Handle = entity;
    }

    void OnUpdate(float ts)
    {
        if(Input.MouseButtonPressed(Mouse::LeftButton))
            return;

        ref TransformComponent tr = tc.Translation;
        int dx = (Input.KeyPressed(Key::Right) || Input.KeyPressed(Key::D))
                -(Input.KeyPressed(Key::Left)  || Input.KeyPressed(Key::A));
        int dz = (Input.KeyPressed(Key::Down)  || Input.KeyPressed(Key::S))
                -(Input.KeyPressed(Key::Up)    || Input.KeyPressed(Key::W));

        Vec3 moveDir = { dx, 0.0f, dz };
        float speed = 0.03f;
        if(dx || dz)
            tr += glm::normalize(moveDir) * speed * ts;
    }
}
