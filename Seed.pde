class Seed extends Cell{
	int radius;
	
	Seed(float _x, float _y)
	{
		super(_x, _y);
		this.lock();
		radius = 10;
	}

	@Override
	void display()
	{
		fill(255,255,255, 80);
		noStroke();
		ellipse(x, y, radius, radius);
	}

	void setPosition(PVector _pos)
	{
		x += _pos.x;
		y += _pos.y;

		if(x  < 1)
		{
			x = width - 1 ;
		}

		if( y < 1)
		{
			y = height - 1;
		}

		if( x > width -1)
		{
			x = 0;
		}

		if(y > height - 1)
		{
			y = 0;
		}
	}
}