class Creature{
	ArrayList<Cell> cells;
	ArrayList<VerletSpring2D> bonds;

	int MAXSIZE;

	int age;
	Seed center;
	PShape creatureShape;
	color creatureColor;
	ArrayList<Integer> crClr;

	float phi;
	float growthRadius;

	PVector acceleration;
	PVector velocity;
	
	float MAXSPEED;	
	float MAXFORCE;


	Creature()
	{
		cells = new ArrayList<Cell>();
		bonds = new ArrayList<VerletSpring2D>();
		crClr = new ArrayList<Integer>();

		MAXSIZE = 70;
		creatureColor = color(random(255), random(255), random(255));
		
		//phi = 137.5;
		phi = random(360);
		growthRadius = 5;

		spawn(90);
		//initColors();
		age = 0;
		
		MAXFORCE = 0.1f;
		MAXSPEED = 4;
		
		acceleration = new PVector(0,0);
		velocity = new PVector(0,0);

		//generateShape();
	}
	void spawn(int _count)
	{
		center = new Seed(random(0,width), random(0,height));
		cells.add(center);
		crClr.add(color(255,255,255, 80));
		grow();
		// for(int i=0;i<_count;i++)
		// {
		// 	Cell c = new Cell(random(0,width), random(0,height));
		// 	cells.add(c);
		// }
		// connectCells();
	}

	boolean grow()
	{
		int cellCount = cells.size();
		if(cellCount < MAXSIZE)
		{
			int n = cellCount+1;
			float x, y;
			float ang = radians(phi*n);
			float r = growthRadius * sqrt(cellCount);

			x = center.x + (cos(ang)*r);
			y = center.y + (sin(ang)*r);

			Cell newborn = new Cell(x,y);
		
			crClr.add(color(cellCount,255-cellCount*6, random(cellCount), 60));
			cells.add(newborn);
			if(cellCount < 6)
			{	
				VerletSpring2D s = new VerletSpring2D(center, newborn, 5, 0.02f);
				bonds.add(s);
			}
			else{

				Cell[] neighours = findNearestTwo(newborn);
				VerletSpring2D s1 = new VerletSpring2D(neighours[0], newborn, 5, 0.02f);
				VerletSpring2D s2 = new VerletSpring2D(neighours[1], newborn, 5, 0.02f);
				
				bonds.add(s1);
				bonds.add(s2);
			}
			return true;
		}
		else 
		{
			return false;	
		}

	}

	
	void viewShape()
	{
		int clr = 0;
		beginShape(TRIANGLE_FAN);
		for(Cell c : cells)
		{
			noStroke();
			color cc = crClr.get(clr);
			fill(cc);
			vertex(c.x, c.y);
			clr++;
		}
		endShape();
	}

	void generateShape()
	{
		creatureShape = createShape(TRIANGLE_STRIP);
		
		for(Cell c : cells)
		{
			creatureShape.noStroke();
			creatureShape.fill(random(255), random(255), random(255));
			creatureShape.vertex(c.x, c.y);
		}
		creatureShape.end();
	}


	Cell findNearest(Cell _c)
	{
  		Cell nearest = null;
  		float minDist = 10000;
  		for(Cell c : cells)
  		{
  			PVector pA, pB;
  			pA = new PVector(_c.x, _c.y);
  			pB = new PVector(c.x, c.y);
    		if(c != _c)
    		{
      			float distance = PVector.dist(pA,pB);
      			if(distance<minDist)
      			{
        			minDist = distance;
        			nearest = c;
      			}	      
    		}
  		}
  		//println(minDist);
  		return nearest;
	}

	Cell[] findNearestTwo(Cell _c)
	{
  		Cell[] nearestTwo = new Cell[2];
  		nearestTwo[0] = findNearest(_c);
  		float minDist = 10000;
  		for(Cell c : cells)
  		{
  			PVector pA, pB;
  			pA = new PVector(_c.x, _c.y);
  			pB = new PVector(c.x, c.y);
    		if(c!= _c)
    		{
      			if(c != nearestTwo[0])
      			{
     		   		float distance = PVector.dist(pA,pB);
      				if(distance<minDist)
      				{
        				minDist = distance;
        				nearestTwo[1] = c;
      				}	      
      			}		      
    		}
  		}		  
  		return nearestTwo;  
	}

	void connectCells()
	{
		println("connecting cells");
		if(cells.size()< 6)
		{
			for(Cell c: cells)
			{
				VerletSpring2D s = new VerletSpring2D(center, c, 10, 0.01f);
				bonds.add(s);
			}
		}
		else {
			
		}
	}
	void updateShape()
	{
		for(int i=0; i<cells.size();i++)
		{
			Cell c = cells.get(i);
			creatureShape.setVertex(i,c.x, c.y);
		}
	}
	

	ArrayList<Cell> getCells()
	{
		return cells;
	}

	boolean update()
	{
		age +=1;

		if(grow())
		{
			return true;
		}
		else  	{
			return false;
		}
		
	}

	void updatePosition()
	{
		velocity.add(acceleration);
		velocity.limit(MAXSPEED);
		
		center.setPosition(velocity);
		acceleration.mult(0);
	}

	void applyForce(PVector force)
	{
		acceleration.add(force);
	}

	void follow(Flowfield ff)
	{

		PVector location = new PVector(center.x, center.y);

		PVector desired = ff.lookUp(location);
		desired.mult(MAXSPEED);

		PVector steer = PVector.sub(desired, velocity);
		steer.limit(MAXFORCE);
		applyForce(steer);
		
		updatePosition();
	}

	void display()
	{
		for(VerletSpring2D s : bonds)
		{
			stroke(255,30);
			strokeWeight(1);
			line(s.a.x, s.a.y, s.b.x, s.b.y);
		}
		viewShape();
		for(Cell c : cells)
		{

			c.display();
		}
	}
	
	void clean()
	{

	}
}