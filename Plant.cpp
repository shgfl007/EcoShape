//
//  Plant.cpp
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#include "Plant.h"

Plant::Plant(float _x, float _y){
    x = _x;
    y = _y;
    x1 = x+50;
    y1 = y+50;
    x2 = x+25;
    y2 = x+25;
    x3 = x+75;
    y3 = y;
    
    status = 1;
    active = true;
}

void Plant::update()
{
    //try to find a way to animate plant, add the function here
    //change the status number
    
    if (status == 3) {
        ofSetColor(200, 255, 255);
        
    }
    if (status == 4) {
        active = false;
    }
    
}

void Plant::draw()
{
    if (active) {
        ofSetColor(0, 200*(ofRandom(0.8, 1.2)), 100*(ofRandom(0.8,1.2)));
        ofCurve(x, y, x1, y1, x2, y2, x3, y3);
    }
    else
        ofCurve(0, 0, 0, 0, 0, 0, 0, 0);
}

void Plant::setActive(bool isActive)
{
    active = isActive;
}