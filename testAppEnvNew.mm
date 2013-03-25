#include "testApp.h"


int myCircleX;
int myCircleY;
int countC = 0;
int countH = 0;
int countP = 0;
int countTotal = 0;
int Hrank_STANDARD = 2;


//--------------------Environment part 1-----------------------------
int r = 255;
int g = 255;
int b = 255;


int fr = 200; int fg = 241; int fb = 70;
int sr = 146; int sg = 196; int sb=109;
int tr = 40; int tg = 126; int tb = 125;
int fourr = 35; int fourg = 73; int fourb = 111;
int fiver = 35; int fiveg = 91; int fiveb = 147;
int sixr = 23; int sixg=182; int sixb = 211;
int sevenr =4; int seveng = 216; int sevenb= 255;
//--------------------Environment part 1 ends-----------------------------


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
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
	//ofBackgroundHex(0x8c8377);
    ofxMultiTouch.addListener(this);
    
    
    //add-on testing
    
    box2d.init();
    box2d.setGravity(0, 1);
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
        
    //add-on testing ends here
    
    
    
    //--------------------Environment part 2-----------------------------

    counter = 0.0;
    counter2 = 0.0;
    counter3 =0.0;
    counter4 =0.0;
    counter5=0.0;
    counter6=0.0;
    counter7=0.0;
    
    //--------------------Environment part 2 ends-----------------------------

    
    
    
    
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
    //ofVec2f gravity = ofxAccelerometer.getForce();
    //gravity.y *= ( -1 * ofRandom(-1,1));
    //gravity.x *= (-1 * ofRandom(-1,1));
    
    // gravity *= 5;
    
    // box2d.setGravity(gravity);
    box2d.update();
    //add-on testing ends here
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
    
    
    
    
    //--------------------Environment part 3-----------------------------

    //background change
    if(countTotal > 20 && r > 150 && g > 150 && b > 150 )
    {   
        r--;g--;b--;
    }   
    if(countTotal > 30 && r > 0 && g > 0 && b > 0 )
    {   
        r--;g--;b--;
    }
    //changing back
    if(countTotal < 30 && r <160 && g < 160 && b < 160)
    {
        r++; g++; b++;
    }
    if(countTotal < 20 && r < 255 && g < 255 && b < 255)
    {
        r++; g++; b++;
    }
    
    //top first layer
    //int fr = 200; int fg = 241; int fb = 70;
    if(countTotal > 20 && fb <=200 )
    {   
        fb+=2;
    }
    if(countTotal > 30 && fr <= 230 && fb <= 230 )
    {   
        fr++;fb++;
    }
    //changing back
    if(countTotal < 30 && fr >= 200 && fb >= 200 )
    {   
        fr--;fb--;
    }
    if(countTotal < 20 && fb >= 75 )
    {   
        fb-=2;
    }    
    
    
    //top second layer
    //int sr = 146; int sg = 196; int sb=109;
    if(countTotal > 20 && sr <=160 && sb <= 160 )
    {   
        sr++;sb+=3;
    }
    if(countTotal > 30 && sr <= 196 && sb <= 196 )
    {   
        sr++;sb++;
    }
    if(countTotal < 30 && sr >= 163 && sb >= 163 )
    {   
        sr--;sb--;
    }
    if(countTotal < 20 && sr > 146 && sb > 109 )
    {   
        sr--;sb-=3;
    }
    
    //top third layer
    //int tr = 40; int tg = 126; int tb = 125;

    if(countTotal > 20 && tr <=80)
    {   
        tr++;
    }
    if(countTotal > 30 && tr <= 126)
    {   
        tr++;
    }
    if(countTotal < 30 && tr > 80)
    {   
        tr--;
    }
    if(countTotal < 20 && tr > 40)
    {   
        tr--;
    }
    
    //top fourth layer
    //int fourr = 35; int fourg = 73; int fourb = 111;
    
    if(countTotal > 20 && fourr < 90 && fourg <90)
    {   
        fourr+=2; fourg++;  
    }
    if(countTotal > 30 && fourr <= 111 && fourg <= 111)
    {   
        fourr+=2; fourg++;  
    }
    if(countTotal < 30 && fourr > 90 && fourg > 90)
    {   
        fourr-=2; fourg--;  
    }
    if(countTotal < 20 && fourr > 35 && fourg > 73)
    {   
        fourr-=2; fourg--;  
    }
    
    //top fifth layer
    //int fiver = 35; int fiveg = 91; int fiveb = 147;

    if(countTotal > 20 && fiver < 90 )
    {   
        fiver+=2;  
    }
    if(countTotal > 30 && fiver <= 147 && fiveg <= 147)
    {   
        fiver++; fiveg++;  
    }  
    if(countTotal < 30 && fiver > 90 )
    {   
        fiver--; fiveg--;
    }
    if(countTotal < 20 && fiver > 35)
    {   
        fiver-=2; 
    }  
    
    //top sixth layer
    //int sixr = 23; int sixg=182; int sixb = 211;

    if(countTotal > 20 && sixr < 182 )
    {   
        sixr+=2;  
    }
    if(countTotal > 30 && sixr <= 211 && sixg <= 211)
    {   
        sixr++; sixg++;  
    }  
    if(countTotal < 30 && sixr > 182 )
    {   
        sixr--; sixg--;
    }
    if(countTotal < 20 && sixr > 23)
    {   
        sixr-=2; 
    }  
    
    //top seventh layer
    //int sevenr =4; int seveng = 216; int sevenb= 255;
    if(countTotal > 20 && sevenr < 216 )
    {   
        sevenr+=2;  
    }
    if(countTotal > 30 && sevenr <= 255 && seveng <= 255)
    {   
        sevenr++; seveng++;  
    }  
    if(countTotal < 30 && sevenr > 216 )
    {   
        sevenr--; seveng--;  
    }
    if(countTotal < 20 && sevenr > 4)
    {   
        sevenr-=2; 
    }  
    
    //add 0.029 to our counter
	counter = counter + 0.010f;
    counter2 = counter2 + 0.015f;
    counter3 += 0.020f;
    counter4 += 0.025f;
    counter5 += 0.030f;
    counter6 += 0.035f;
    
    counter7 += 0.040f;
    
    //--------------------Environment part 3 ends-----------------------------

    
    
    
}

//--------------------------------------------------------------
void testApp::draw(){
    float k = 0.0;
    
    
    
    
    //--------------------Environment part 4-----------------------------

    //background
    ofSetColor(r, g, b);
    k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter7 - k) + 30.0));
		k += 0.4;
	}    
    
    
    //top seventh layer
    ofSetColor(sevenr, seveng, sevenb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter7 - k) + 15.0));
		k += 0.4;
	}    
    
    //top sixth layer
    ofSetColor(sixr, sixg, sixb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter6 - k) + 14.0));
		k += 0.4;
	}  
    //top fifth layer
    ofSetColor(fiver, fiveg, fiveb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter5 - k) + 13.0));
		k += 0.4;
	}   
    
    //top fourth layer
    ofSetColor(fourr, fourg, fourb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter4 - k) + 12.0));
		k += 0.4;
        
	} 
    //top third layer
    ofSetColor(tr, tg, tb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter3 - k) + 11.0));
		k += 0.4;
	}
    
    //top second layer
	//This is doing it again but for a different color
    
	ofSetColor(sr, sg, sb);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter2 - k) + 9.0));
		k += 0.4;
	}
    
    //top first layer
    ofSetColor(fr, fg, fb);
    k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter - k) + 8.0));
		k += 0.4;
	}
    //ground
    ofSetColor(242, 242, 242);
	k = 0;
	for(int i = 0; i < ofGetWidth(); i+= 50)
	{
		ofRect(i+5, ofGetHeight(), 50, -50 * (sin(1.4 * counter2 - k) + 2.0));
		k += 0.2;
	}
    
    
    //--------------------Environment part 4 ends-----------------------------

    
    
    
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
    ofDrawBitmapString(ofToString(countTotal,0), 20, 70);
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

