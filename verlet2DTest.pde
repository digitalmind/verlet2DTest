import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import controlP5.*;

VerletPhysics2D physics;

//Creature cr;
CreatureManager cm;
Flowfield grid;

void setup()
{
	size(800,600, P3D);
  //size(displayWidth, displayHeight, P2D);

	//cr = new Creature();
	cm = new CreatureManager();

	colorMode(HSB);
	initPhysics();
  
	grid = new Flowfield(10);

}


void draw()
{
	frame.setTitle("Fps: "+(int)frameRate);
	background(0);
	physics.update();
	
	cm.run(grid);
	cm.display();
	if(cm.isGrown())
	{
		addNewCellsToSystem();
	}

}


void addNewCellsToSystem()
{

	for(Cell c : cm.newCells)
	{
		physics.addParticle(c);
		
		AttractionBehavior repel = new AttractionBehavior(c, 10, -2.0f);
		physics.addBehavior(repel);
	}

	for(VerletSpring2D s : cm.newBonds)
	{
		physics.addSpring(s);
	}
	//println(cm.newCells.size()+" cells added on this epoch!");
}

void initPhysics()
{
	physics = new VerletPhysics2D();
	for(Creature cr : cm.creatures)
	{
		for(Cell c : cr.cells)
		{
			physics.addParticle(c);
			AttractionBehavior repel = new AttractionBehavior(c, 5, -2.0f);
			physics.addBehavior(repel);

			if(c.isLocked())
			{
				AttractionBehavior corePull = new AttractionBehavior(c, 50, 1.0f);
				physics.addBehavior(corePull);

				AttractionBehavior corePush = new AttractionBehavior(c, 25, -3.0f);
				physics.addBehavior(corePush);
			}
		}

		for(VerletSpring2D s : cr.bonds)
		{
			physics.addSpring(s);
		}
	}
	Rect border = new Rect(new Vec2D(-10,-10), new Vec2D(width+10, height+10));
	physics.setWorldBounds(border);
		
}

void mousePressed()
{

}

void keyPressed()
{
	switch(key){
		case 'r' :
		{
			grid.init();
			println("grid rearranged!");
			break;
		}

	}
}

