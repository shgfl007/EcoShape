#include "testApp.h"
#include "Carnivore.h"
#include "Herbivore.h"

int myCircleX;
int myCircleY;
int countC = 0;
int countH = 0;
int countP = 0;
int countTotal = 0;
int Hrank_STANDARD = 2;

Carnivore *the_list[10];
Herbivore *H_list[10];



//eat function, please keep the higher rank creature as A!!!!!!!
void eat(Creature A, Creature B)
{
    if (A.rank > B.rank && A.hungerM < 3 && A.rank > Hrank_STANDARD && B.rank >0) {
        //A is carnivore, b is either carnivore or herbivore
        B.setActive(false);
        
        if (B.rank<=Hrank_STANDARD && B.rank >0) {
            //B is a Herbivore
            countH--;
            A.hungerM++;
        }
        else {
            // B is a Carnivore
            countC--;
            A.hungerM+=2;
        }
        
    }
    else if(A.rank > B.rank && A.rank<=Hrank_STANDARD && A.rank>0 && B.rank==0 && A.hungerM < 3){
        // A is a Herbivore, B is a plant
        B.setActive(false);
        countP--;
        A.hungerM++;
    }
    
   
}



//--------------------------------------------------------------
void testApp::setup(){
	
    ofRegisterTouchEvents(this);
    ofxAccelerometer.setup();
    ofxiPhoneAlerts.addListener(this);
	ofSetFrameRate(30);

    
	myCircleX=300;
    myCircleY = 200;
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackgroundHex(0x8c8377);
    ofxMultiTouch.addListener(this);
    Carnivore *test = new Carnivore(200,300,5,5);
    the_list[0] = test;
    countTotal++;
    Herbivore *test0 = new Herbivore(100,100,2);
    H_list[0] = test0;
    countP++;
    
    //add-on testing
    
    box2d.init();
    box2d.setGravity(0, 10);
    box2d.setFPS(60);
    box2d.registerGrabbing();
    box2d.createBounds();
    box2d.setIterations(1, 1); // minimum for IOS
    
    for (int i=0; i<10; i++) {
        ofxBox2dCircle c;
        c.setPhysics(1, 0.4, 0.4);
        c.setup(box2d.getWorld(), ofRandomWidth(), ofRandomHeight(), ofRandom(13, 25));
        circles.push_back(c);
    }
    //add-on testing ends here
}

//--------------------------------------------------------------
void testApp::update(){

    for(int i = 0; i< countTotal; i++)
    {(*the_list[i]).update();}
    for (int i = 0; i < countP; i++) {
        //(*P_list[i]).update();
    }
    
    //add-on testing
    //ofVec2f gravity = ofxAccelerometer.getForce();
    //gravity.y *= -1;
    //gravity *= 30;
    //box2d.setGravity(gravity);
    
    box2d.update();
    //add-on testing ends here
    
    countTotal = countP + countH + countC;

}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofSetColor(54);
	ofDrawBitmapString("Multitouch and Accel Example", 10, 20);

    /*ofSetColor(200, 200, 100);
	ofCircle(200, 300,60);
    
    ofSetColor(100, 200, 100);
    ofCircle(500, 500, 100);
    
    ofSetColor(200, 150, 100);
    ofCircle(myCircleX, myCircleY, 60);*/
    
    /*ofFill();
	for (int i = 0; i < 100; i++){
		ofSetColor((int)ofRandom(0,255),(int)ofRandom(0,255),(int)ofRandom(0,255));
		ofRect(ofRandom(250,350),ofRandom(350,450),ofRandom(10,20),ofRandom(10,20));
	}
	ofSetHexColor(0x000000);
	ofDrawBitmapString("rectangles", 275,500);*/
    for (int i = 0; i<countTotal; i++) {
        the_list[i]->draw();
    }
    for (int i = 0; i<countH; i++) {
        H_list[i]->draw();
    }
    
    //add-on testing
    ofSetHexColor(0xABDB44);
    for(vector<ofxBox2dCircle>::iterator it = circles.begin(); it != circles.end(); ++it) {
        it->draw();
    }
    
    ofSetColor(90);
    ofDrawBitmapString("double tap to add more", 20, 30);
    ofDrawBitmapString(ofToString(ofGetFrameRate(), 0)+" fps", 20, 50);
    //add-on testing ends here

}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

    

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){


}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    /*Herbivore *testC = new Herbivore(touch.x,touch.y,1);
    ofLog(OF_LOG_VERBOSE, "touch down at (%d,%d)",touch.x,touch.y);
    countH++;
    
    H_list[countH-1] = testC;*/

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    Carnivore *testC = new Carnivore(touch.x,touch.y,ofRandom(Hrank_STANDARD, 5),10);
    ofLog(OF_LOG_VERBOSE, "touch down at (%d,%d)",touch.x,touch.y);
    countC++;
    countTotal++;
    the_list[countTotal-1] = testC;
    
    //add -on testing
    /*ofxBox2dCircle c;
    c.setPhysics(1, 0.4, 0.4);
    c.setup(box2d.getWorld(), touch.x, touch.y, ofRandom(13, 25));
    circles.push_back(c);*/
    //add-on testing ends here
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

