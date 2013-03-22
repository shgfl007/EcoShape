#include "testApp.h"


int myCircleX;
int myCircleY;
int countC = 0;
int countH = 0;
int countP = 0;
int countTotal = 0;
int Hrank_STANDARD = 2;


vector<ofxBox2dRect> carnivores;
vector<ofxBox2dCircle> herbivores;
vector<ofxBox2dPolygon> plants;


//eat function, please keep the higher rank creature as A!!!!!!!
void eat(ofxBox2dBaseShape A, ofxBox2dBaseShape B)
{
    if (A.rank > B.rank && A.hungerM < 3 && A.rank > Hrank_STANDARD && B.rank >0) {
        //A is carnivore, b is either carnivore or herbivore
        B.alive = false;
        
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
        B.alive = false;
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

    
    //add-on testing
    
    box2d.init();
    box2d.setGravity(0, 0.1);
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

 
    
    //add-on testing
    ofVec2f gravity = ofxAccelerometer.getForce();
    //gravity.y *= ( -1 * ofRandom(-1,1));
    //gravity.x *= (-1 * ofRandom(-1,1));
    
    gravity *= 5;

    box2d.setGravity(gravity);
    box2d.update();
    //add-on testing ends here
    for(vector<ofxBox2dRect>::iterator it = carnivores.begin(); it != carnivores.end(); ++it) {
        it->hungerM-=0.5;
    }
    
    for(vector<ofxBox2dCircle>::iterator it = herbivores.begin(); it != herbivores.end(); ++it) {
        it->hungerM-=0.5;
    }
    
    countTotal = countP + countH + countC;

}

//--------------------------------------------------------------
void testApp::draw(){
    

    
    //add-on testing
    
    for(vector<ofxBox2dRect>::iterator it = carnivores.begin(); it != carnivores.end(); ++it) {
        if (it->rank==2) {
            ofSetHexColor(0xFF9300);
        }
        else if (it->rank==3){
            ofSetHexColor(0xE84200);
        }
        else if(it->rank == 4){
            ofSetHexColor(0x8E0B00);
        }
        it->draw();
    }
    
    ofSetHexColor(0xCFDB79);
    for(vector<ofxBox2dCircle>::iterator it = herbivores.begin(); it != herbivores.end(); ++it) {
        it->draw();
    }
    
    ofSetHexColor(0x27855E);
    ofFill();
    for(int i = 0; i<curves.size(); i++)
    {
        curves[i].draw();
        
    }
    for (int i = 0; i < plants.size(); i++) {
        plants[i].draw();
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
    if(touch.id == 1)
    {
        ofxBox2dCircle h;
        h.setPhysics(0.1, 0.4, 1);
        h.setup(box2d.getWorld(), touch.x, touch.y, ofRandom(10,15));
        herbivores.push_back(h);
        countH++;
    };
    
    if (touch.id == 2) {
        curves.push_back(ofPolyline());
        curves.back().addVertex(touch.x,touch.y);
    }

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    /*ofxBox2dCircle h;
    h.setPhysics(0.1, 0.4, 1);
    h.setup(box2d.getWorld(), touch.x, touch.y, ofRandom(10,15));
    herbivores.push_back(h);*/
    if (touch.id == 2) {
        curves.back().addVertex(touch.x, touch.y);
    }
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    /*ofxBox2dPolygon p;
    p.setPhysics(0.1, 0.4, 1);
    p.setup(box2d.getWorld());
    plant.push_back(p);*/

    if (touch.id == 2) {
        ofxBox2dPolygon plant;
        curves.back().simplify();
        
        for (int i = 0; i<curves.back().size(); i++) {
            plant.addVertex(curves.back()[i]);
        }
        
        plant.create(box2d.getWorld());
        plants.push_back(plant);
    }

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    //add -on testing
    ofxBox2dRect c;
    c.setPhysics(1, -0.4, 0.4);
    ofRectangle _rect;
    _rect.x = touch.x;
    _rect.y = touch.y;
    _rect.height = ofRandom(20, 25);
    _rect.width = ofRandom(18,22);
    c.setup(box2d.getWorld(), _rect);
    carnivores.push_back(c);
    //add-on testing ends here
    countC++;
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

