#include "Images/powerups.h"

struct {
	int x;
	int y;
	u32 height;
	u32 width;
	int type;
} PowerUp;

PowerUp = {510*1920*3, 0, 60, 60, WumpaFruit};


enum Types {
	WumpaFruit,			// Subtracts Points
	Skull,				// Adds Points
	Clock				// Slows Down Platforms
}Type;



