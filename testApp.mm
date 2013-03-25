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
        B.exist = false;
        
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
        B.exist = false;
        countP--;
        A.hungerM++;
    }
    
   
}
//--------------------------------------------------------------

bool bodiesAreTouching(b2Body* body1, b2Body* body2){
    for (b2ContactEdge* edge = body1->GetContactList(); edge; edge=edge->next) {
        if ( !edge->contact->IsTouching() )
			continue;
		b2Body* bA = edge->contact->GetFixtureA()->GetBody();
		b2Body* bB = edge->contact->GetFixtureB()->GetBody();
		if ( ( bA == body1 && bB == body2 ) || ( bB == body1 && bA == body2 ) )
			return true;
    }
    return false;
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

    
    
    
    box2d.init();
    box2d.setGravity(0, 0.1);
    box2d.setFPS(60);
    box2d.registerGrabbing();
    box2d.createBounds();
    box2d.setIterations(1, 1); // minimum for IOS
    
    //register the listener so that we get the events
    ofAddListener(box2d.contactStartEvents, this, &testApp::contactStart);
    ofAddListener(box2d.contactEndEvents, this, &testApp::contactEnd);
    
    //load sound
    for (int i=0; i<N_SOUNDS; i++) {
        
        sound[i].loadSound("sfx/" + ofToString(i)+ ".mp3");
        sound[i].setMultiPlay(true);
        sound[i].setLoop(false);
    }
}

//----------------------------------------------------------------------

void testApp::contactStart(ofxBox2dContactArgs &e){
    if (e.a != NULL && e.b != NULL) {
        
        //two carnivores
        if (e.a->GetType() == b2Shape::e_circle && e.b->GetType() == b2Shape::e_circle) {
            if (e.a->GetBody()->GetUserData()) {
                
                SoundData * aData = (SoundData*)e.a->GetBody()->GetUserData();
                SoundData * bData = (SoundData*)e.b->GetBody()->GetUserData();
                
                if (aData) {
                    aData->bHit = true;
                    sound [aData->soundID].play();
                }
                
                if (bData) {
                    bData->bHit = true;
                    sound[bData->soundID].play();
                }
            }
        }
        
        
    }
}

//--------------------------------------------------------------

void testApp::contactEnd(ofxBox2dContactArgs &e){
    if (e.a != NULL && e.b !=NULL) {
        SoundData * aData = (SoundData*)e.a->GetBody()->GetUserData();
        SoundData * bData = (SoundData*)e.b->GetBody()->GetUserData();
        
        if (aData) {
            aData->bHit = false;
        }
        
        if (bData) {
            bData->bHit = false;
        }
    }
}

//--------------------------------------------------------------
void testApp::update(){
 
    
    //add-on testing
    ofVec2f gravity = ofxAccelerometer.getForce();

    
    gravity *= 5;

    box2d.setGravity(gravity);
    box2d.update();
    
    vector<ofxBox2dRect> _tempC;
    vector<ofxBox2dCircle> _tempH;
    vector<ofxBox2dPolygon> _tempP;
    
    for (vector<ofxBox2dRect>::iterator it = carnivores.begin(); it!=carnivores.end(); ++it) {
        for (vector<ofxBox2dRect>::iterator it2 = carnivores.begin(); it2!=carnivores.end(); ++it2) {
            if(it->getB2DPosition()== it2->getB2DPosition())
            {
                if (it->rank>it2->rank) {
                    eat(*it, *it2);
                }else eat(*it2, *it);
                
            }
            
        }
        
    }
    
    
    for(vector<ofxBox2dRect>::iterator it = carnivores.begin(); it != carnivores.end(); ++it) {
        it->hungerM-=0.0000000005;
        if(it->hungerM==0)it->exist=false;
        if (it->exist==false) {
            it->destroy();
            countC--;
        }else _tempC.push_back(*it);
    }
    
    for(vector<ofxBox2dCircle>::iterator it = herbivores.begin(); it != herbivores.end(); ++it) {
        it->hungerM-=0.0000000005;
        if(it->hungerM==0)it->exist=false;
        if (it->exist==false) {
            it->destroy();
            countH--;
        }else _tempH.push_back(*it);
    }
    
    for(vector<ofxBox2dPolygon>::iterator it = plants.begin(); it != plants.end(); ++it) {
        it->hungerM-=0.0000000005;
        if(it->hungerM==0)it->exist=false;
        if (it->exist==false) {
            it->destroy();
            countP--;
        }else _tempP.push_back(*it);
    }
   
    
    
    carnivores = _tempC;
    herbivores = _tempH;
    plants = _tempP;
    
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
        SoundData * data = (SoundData*)it->getData();
        if (data && data->bHit) {
            ofSetHexColor(0xff0000);
        }
            it->draw();
        
    }
    

    
    ofSetHexColor(0xCFDB79);
    for(vector<ofxBox2dCircle>::iterator it = herbivores.begin(); it != herbivores.end(); ++it) {
            it->draw();
    }

    ofSetHexColor(0x27855E);
    /*ofFill();
    for(int i = 0; i<curves.size(); i++)
    {
        curves[i].draw();
     
    }*/
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

    if (touch.id == 2) {
        curves.back().addVertex(touch.x, touch.y);
    }
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){


    if (touch.id == 2) {
        ofxBox2dPolygon plant;
        curves.back().simplify();
        
        for (int i = 0; i<curves.back().size(); i++) {
            plant.addVertex(curves.back()[i]);
        }
        
        plant.create(box2d.getWorld());
        plants.push_back(plant);
        countP++;
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

