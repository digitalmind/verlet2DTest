import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import controlP5.*;
import java.util.*;

ControlP5 ctrl;

VerletPhysics2D physics;

CreatureManager cm;
Flowfield grid;

ArrayList<Food> foods;

PFont font;

boolean HUDflag;
boolean GRIDflag;

void setup()
{
<<<<<<< HEAD
	size(800,600, P2D);
//	size(displayWidth, displayHeight, P3D);
=======
	size(800,600, P3D);
  //size(displayWidth, displayHeight, P2D);
    hint(DISABLE_DEPTH_MASK);
>>>>>>> depth check disabled

	font = loadFont("Consolas-14.vlw");
	cm = new CreatureManager();

	colorMode(HSB);
	
	initFood();
	
	initPhysics();
  	
  	initHUD();
  	initGui();

	grid = new Flowfield(10);
	GRIDflag = false;

}


void draw()
{
	frame.setTitle("Fps: "+(int)frameRate);
	background(0);

	if(GRIDflag)
	{
		grid.display();
	}
	physics.update();
	
	cm.run(grid);
	
	cm.display();
	if(cm.isGrown())
	{
		addNewCellsToSystem();
	}

	if(HUDflag)
	{
		viewHUD();
	}

	Iterator<Food> foodIterator = foods.iterator();
	while(foodIterator.hasNext())
	{
		Food f = foodIterator.next();
		f.update();
		f.display();

		if(f.age<0)
		{
			foodIterator.remove();
			println("Removed!");
		}
	}
	

}
void initFood()
{
	foods = new ArrayList<Food>();

}
void initGui()
{
	ctrl = new ControlP5(this);
	
	//ControlWindow cw = ctrl.addControlWindow("Control Panel", 300,300);
	//cw.hideCoordinates();


}

void initHUD()
{
	HUDflag = true;
}

void viewHUD()
{
	fill(200);
	textFont(font, 14);
	text("Creature count: "+cm.getCreatureCount()+"\nTotal cell count: "+cm.getTotalCellCount(), 5,14);
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
	int count = (int) random(0,5);
	//println(count);
	for(int i=0; i<count;i++){
	//	println("i = "+i);
		foods.add(new Food());

	}
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

		case 'h' :
		{
			HUDflag = !HUDflag;
			break;
		}
		case 'g' :
		{
			GRIDflag = !GRIDflag;
			break;
		}

	}
}

