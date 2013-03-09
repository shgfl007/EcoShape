//
//  Plant.h
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#ifndef __artgame__Plant__
#define __artgame__Plant__

#include <iostream>
#include "ofColor.h"
#include "Creature.h"
#include "ofmain.h"

class Plant : public Creature {
	
public:
    //method
    void update();
    void draw();
    void setActive(bool);
    
    //constructor
    Plant(float _x, float _y);
    
    //variables
    //float x; //position
    //float y;
    //int rank;
    //int seq; //sequent #
    //ofColor Ccolor;
    //bool active;
    //int hp;//health point
    int status;
    
private:
    float x1, y1,x2, y2, x3, y3;
    
    
};

#endif /* defined(__artgame__Plant__) */
