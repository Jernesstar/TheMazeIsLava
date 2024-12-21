#pragma once

#include <VolcaniCore/Graphics/Camera.h>

using namespace VolcaniCore;

namespace TheMazeIsLava {

class IsometricCamera : public Camera {
public:
	float R = 10.0f;

public:
	IsometricCamera(float r = 10.0f)
		: Camera(Camera::Type::Ortho), R(r)
	{
		SetDistance(R);
	}
	~IsometricCamera() = default;

	void SetDistance(float r) {
		R = r;
		Position = R * glm::vec3{
			glm::sin(glm::radians(45.0f)),
			glm::sin(glm::radians(35.264f)),
			glm::sin(glm::radians(45.0f))
		};
		Direction = -glm::normalize(Position);
		Near = 0.001f;
		Far = 10'000.0f;

		CalculateView();
		CalculateProjection();
	}

private:
	void CalculateProjection() override {
		Projection = glm::ortho(-(float)ViewportWidth  / (R),
								 (float)ViewportWidth  / (R),
								-(float)ViewportHeight / (R),
								 (float)ViewportHeight / (R), Near, Far);
		ViewProjection = Projection * View;
	}
	void CalculateView() override {
		glm::vec3 up = { 0.0f, 1.0f, 0.0f };
		View = glm::lookAt(Position, Position + R*Direction, up);
		ViewProjection = Projection * View;
	}
	void Resize(uint32_t width, uint32_t height) override {
		ViewportWidth = 480;
		ViewportHeight = 270;
	}
};

}
