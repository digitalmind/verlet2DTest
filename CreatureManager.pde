class CreatureManager{
	ArrayList<Creature> creatures;
	
	ArrayList<Cell> newCells;
	ArrayList<VerletSpring2D> newBonds;
	boolean creaturesGrown;
	Flowfield field;

	CreatureManager()
	{
		creatures = new ArrayList<Creature>();
		newCells = new ArrayList<Cell>();
		newBonds = new ArrayList<VerletSpring2D>();

		initCreatures();
	}

	void run(Flowfield ff)
	{
		field = ff;
	}

	void initCreatures()
	{
		for(int i=0; i<12; i++)
		{
			Creature cr = new Creature();
			creatures.add(cr);
		}
	}




	void display()
	{
		newCells.clear();
		newBonds.clear();

		for(Creature c : creatures)
		{
				if(c.update())
				{
					newCells.add(c.cells.get(c.cells.size()-1));
					newBonds.add(c.bonds.get(c.bonds.size()-1));

					creaturesGrown = true;
				}
				else  {
					creaturesGrown = false;
				}
			//c.updateShape();
			c.follow(field);
			c.display();
		}
	}

	boolean isGrown()
	{
		return creaturesGrown;
	}




}