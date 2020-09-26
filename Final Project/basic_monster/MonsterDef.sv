typedef struct {
	logic [10:0] height;
	logic [10:0] width; 
	logic [35:0][23:0] sprite [44:0];
	logic [10:0] pos_x;
	logic [10:0] pos_y;
} monster_t;