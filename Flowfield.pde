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
		long seed = (long)random(10);
		noiseSeed(seed);
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

	// void render()
	// {
	// 	for(int i=0; i<cols; i++)
	// 	{
	// 		for(int j=0; j<rows;j++)
	// 		{

	// 		}
	// 	}

	// }


  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j],i*resolution,j*resolution,resolution-2);
      }
    }

  }

  // Renders a vector object 'v' as an arrow and a location 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;
    // Translate to location to render vector
    translate(x,y);
    stroke(90,100);
    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0,0,len,0);
    line(len,0,len-arrowsize,+arrowsize/2);
    line(len,0,len-arrowsize,-arrowsize/2);
    popMatrix();
  }
	PVector lookUp(PVector _pos)
	{
		int column, row;
		
		column = (int)constrain(_pos.x/resolution, 0, cols-1);
		row = (int)constrain(_pos.y/resolution, 0, rows-1);

		return field[column][row].get();
	}
}