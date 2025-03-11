#include "Class/GameState.as"

shared class TheMazeIsLava : IApp
{
	GameStateClass GameState;

	void OnLoad()
	{
		print("Lava Game");
	}

	void OnClose()
	{
		print("Lava Close");
	}

	void OnUpdate(float ts)
	{
		// print("OnUpdate: " + ts);
	}
}
