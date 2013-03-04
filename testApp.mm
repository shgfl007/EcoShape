#include "testApp.h"

int myCircleX;
int myCircleY;
//--------------------------------------------------------------
void testApp::setup(){	
	ofSetFrameRate(60);
    // initialize the accelerometer
	ofxAccelerometer.setup();
	myCircleX=300;
    myCircleY = 200;
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(127,127,127);
    
}

//--------------------------------------------------------------
void testApp::update(){
    myCircleX+=4;
    if(myCircleX>1024)
    {
        myCircleX=300;
    }

}

//--------------------------------------------------------------
void testApp::draw(){
    /*ofSetColor(200, 200, 100);
	ofCircle(200, 300,60);
    
    ofSetColor(100, 200, 100);
    ofCircle(500, 500, 100);
    
    ofSetColor(200, 150, 100);
    ofCircle(myCircleX, myCircleY, 60);*/
    
    ofFill();
	for (int i = 0; i < 100; i++){
		ofSetColor((int)ofRandom(0,255),(int)ofRandom(0,255),(int)ofRandom(0,255));
		ofRect(ofRandom(250,350),ofRandom(350,450),ofRandom(10,20),ofRandom(10,20));
	}
	ofSetHexColor(0x000000);
	ofDrawBitmapString("rectangles", 275,500);

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

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

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

