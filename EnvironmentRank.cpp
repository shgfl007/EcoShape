//
//  EnvironmentRank.h
//  Project2
//
//  Created by Digital Media Lab User on 13-03-10.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef Project2_EnvironmentRank_h
#define Project2_EnvironmentRank_h

#include <iostream>
#include "Environment.h"
#include "Creature.h"
#include "Plant.h"
#include "Carnivore.h"
#include "Herbivore.h"




EnvironmentRank::EnvironmentRank(){
    
    rank = 1;
    live = true;

}

int EnvrironmentRank::ranking()
{
    //if number of creatures > 200
    //subRank = 1
    //live = true
    
    
    
    
    
    //if number of creatures > 300
    //subRank = 2
    //live = true
    
    
    
    
    
    //if number of creatures > 400
    //subRank = 3
    //live = true
    
    
    
    
    
    
    //if number of creatures > 500
    //subRank = 4
    //live = false
    
    
    
    //if (Carnivore > 100 or Herivore > 100) and (plant < 150)
    //subRank2 = 1
    
    
    
    
    //if (Carnivore > 200 or Herivore >200 ) and (plant < 200)
    //subRank2 = 2
    
    
    
    
    //if (Carnivore > 300 or Hervivore > 300) and (plant < 200)
    //subRank2 = 3
    
    
    
    
    //if (Carnivore > 400 or Hervivore > 400) and (plant < 200)
    //subRank2 = 4 
    
    
    
    
    //if (plant == 0 and creatures > 100)
    //rank = 4 
    
    
    
    //Calculation
    //rank = (subRank + subRank2)/2
    
    
    
    
    
    
    
    
    
    
    return rank;
    
    
    
    
    
}


bool EnvironmentRank::live()
{
  int thisRank = getRank();
	if(thisRank == 4)
		live = true;
	else {
		live = false;
	}
	return live;
}



bool EnvironmentRank::beenUpdated(bool updated)
{
    if(this.update())
    {
        return true;
    }
    return false;
    
}

int EnvironmentRank::getRank()
{
	
	return this.rank;

}

void EnvironmentRank::setRank(int rank)
{
	this.rank = rank;

}



#endif
