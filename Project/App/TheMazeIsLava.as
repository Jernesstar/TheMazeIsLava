#include "../Class/GameState.as"

shared class TheMazeIsLava : IApp
{
	GameStateClass GameState;

	void OnLoad()
	{
		JSONSerializer.Deserialize(GameState);
	}

	void OnClose()
	{
		JSONSerializer.Serialize(GameState);
	}

	void OnUpdate(float ts)
	{

	}
}
