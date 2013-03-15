//
//  Carnivore.cpp
//  artgame
//
//  Created by Hisashi on 13-3-9.
//
//

#include "Carnivore.h"

Carnivore::Carnivore(float _x, float _y, int r, int hunger)
{
    x = _x;
    y = _y;
    rank = r;
    width = ofRandom(40, 80);
    height = ofRandom(60, 100);
    active = true;
    hungerM = hunger;
    
    speedX = ofRandom(-1,1);
    speedY = ofRandom(-1,1);
}

void Carnivore::update(){
    
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

void Carnivore::draw(){
    if (active) {
    ofSetColor(255, 50*(ofRandom(0.5, 0.8)), 50*(ofRandom(0.5,0.8)));
        ofRect(x, y, width, height);
    }
    else
        ofRect(-100, -100, width, height);
}

void Carnivore::setActive(bool isActive)
{
    active = isActive;
}

