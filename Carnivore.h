//
//  Carnivore.h
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#ifndef __artgame__Carnivore__
#define __artgame__Carnivore__

#include <iostream>
#include "ofColor.h"
#include "Creature.h"

class Carnivore : public Creature {
	
public:
    //method
    void update();
    void draw();
    void setActive(bool);
    
    //variables
    //float x; //position
    //float y;
    //int rank;
    //int seq; //sequent #
    //ofColor color;
    //bool active;
    int hungerM; // hunger meter
    //int hp;//health point
    
};

#endif /* defined(__artgame__Carnivore__) */
