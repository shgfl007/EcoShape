#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxBox2d.h"
#include "stack.h"
#include <stack>

#define N_SOUNDS 5

class SoundData {
public:
    int soundID;
    bool bHit;
};

class testApp : public ofxiPhoneApp{
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    void contactStart(ofxBox2dContactArgs &e);
    void contactEnd(ofxBox2dContactArgs &e);
    
    
    
    float counter;
    float counter2;
    float counter3;
    float counter4;
    float counter5;
    float counter6;
    float counter7;
    
    
    
    
    ofxBox2d box2d;
    vector<ofxBox2dCircle> circles;
    vector<ofPolyline> curves;
    
    //sound objs
    ofSoundPlayer sound[N_SOUNDS];
    //vector<Carnivore> carnivores;
    //stack<Carnivore> Cs;
};
