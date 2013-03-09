//
//  Creature.h
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#ifndef __artgame__Creature__
#define __artgame__Creature__

#include <iostream>
#include "ofColor.h"
class Creature {
	
public:
    //method
    void update();
    void draw();
    void setActive(bool);
    
    //variables
    float x; //position
    float y;
    int rank;
    int seq; //sequent #
    ofColor color;
    bool active;
    int hungerM; // hunger meter
    int hp;//health point
    
};

#endif /* defined(__artgame__Creature__) */
