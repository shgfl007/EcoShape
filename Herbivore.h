//
//  Herbivore.h
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#ifndef __artgame__Herbivore__
#define __artgame__Herbivore__

#include <iostream>
#include "ofColor.h"
#include "Creature.h"
class Herbivore : public Creature{
	
public:
    //method
    void update();
    void draw();
    void setActive(bool);
    
    //variables
    //float x; //position
    //float y;
    //int Hrank;
    //int seq; //sequent #
    //ofColor Hcolor;
    //bool Hactive;
    int hungerM; // hunger meter
    //int hp;//health point
    
};

#endif /* defined(__artgame__Herbivore__) */
