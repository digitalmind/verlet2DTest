class Food{
	PVector position;
	float energy;
	int age;

	Food()
	{
		position = new PVector(random(width), random(height));
		energy = random(250);
		age = (int) random(250,1000);
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




}