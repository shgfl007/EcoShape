//
//  Herbivore.cpp
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#include "Herbivore.h"

Herbivore::Herbivore(float _x, float _y, int r)
{
    x = _x;
    y = _y;
    rank = r;
    width = ofRandom(40, 80);
    height = ofRandom(60, 100);
    active = true;
    hungerM = 10;
    speedX = ofRandom(-1,1);
    speedY = ofRandom(-1,1);
}

void Herbivore::update(){
    
    /*if (hungerM<3) {
        width*=0.5;
        height*=0.5;
    }*/
    
    if (width < 5 && height<5) {
        setActive(false);
    }
    
    if (x<0) {
        x=0;
        speedX *= -1;
    } else if(x > ofGetWidth()){
        x = ofGetWidth();
        speedX *= -1;
    }
    
    if (y < 0) {
        y = 0;
        speedY *= -1;
    } else if(y > ofGetHeight()){
        y = ofGetHeight();
        speedY *= -1;
    }
    
    x+=speedX;
    y+=speedY;
}

void Herbivore::draw(){
    if (active) {
        ofSetColor(50*(ofRandom(0.5, 0.8)), 255, 50*(ofRandom(0.5,0.8)));
        ofRect(x, y, width, height);
    }
    else
        ofRect(-100, -100, width, height);
}

void Herbivore::setActive(bool isActive)
{
    active = isActive;
}