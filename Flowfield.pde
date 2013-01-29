class Flowfield{
	PVector[][] field;
	int cols, rows;
	int resolution;

	Flowfield()
	{
		resolution = 10;
		
		cols = width/resolution;
		rows = height/resolution;

		field = new PVector[cols][rows];
		init();
	}

	Flowfield(int _r)
	{
		resolution = _r;

		cols = width/resolution;
		rows = height/resolution;

		field = new PVector[cols][rows];
		
		println("Rows: "+rows+ " Cols: "+cols+" ");
		init();
	}

	void init()
	{
		float xoff = 0.0f;
		for (int i = 0; i < cols; i++)
		{
			float yoff = 0.0f;
			for (int j = 0; j < rows; j++)
			{
				 float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
				 field[i][j] = new PVector(cos(theta), sin(theta));
				 yoff += 0.1;
				
			}
			xoff +=0.1;
		}
	}

	PVector lookUp(PVector _pos)
	{
		int column, row;
		
		column = (int)constrain(_pos.x/resolution, 0, cols-1);
		row = (int)constrain(_pos.y/resolution, 0, rows-1);

		return field[column][row].get();
	}
}