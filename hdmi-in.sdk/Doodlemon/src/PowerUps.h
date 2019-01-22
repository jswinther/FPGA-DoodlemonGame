#include "Images/PowerUpImg"

struct {
	int x;
	int y;
	u32 height;
	u32 width;
	int type;
} PowerUp;

PowerUp = {510*1920*3, 0, 60, 60, WumpaFruit};


enum Types {
	Skull,			// Subtracts Points
	WumpaFruit,		// Adds Points
	Clock			// Slows Down Platforms
}Type;



