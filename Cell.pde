class Cell extends VerletParticle2D{
	Cell(float _x, float _y)
	{
		super(_x, _y);
	}
	Cell(Vec2D _pos)
	{
		super(_pos);
	}

	void display()
	{
		strokeWeight(1);
		stroke(255,20);
		point(this.x,this.y);
	}
}