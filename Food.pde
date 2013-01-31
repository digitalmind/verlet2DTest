class Food{
	PVector position;
	float energy;
	int age;

	Food()
	{
		position = new PVector(random(width), random(height));
		energy = random(255);
		age = (int) random(255);
		println(position+"!");
	}

	Food(PVector _pos, float _e, int _a)
	{
		position = _pos;
		energy = _e;
		age = _a;
	}

	void update()
	{
		age -= 1;

	}

	void consume( int consumerCount)
	{
		energy -= consumerCount;
	}

	void display()
	{
		stroke(0);
		fill(51,100,100, age);
		ellipse(position.x, position.y, 10, 10);
		update();

	}


}