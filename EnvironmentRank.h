#ifndef __Project2__EnvironmentRank__
#define __Project2__EnvironmentRank__

#define STANDARD 100

#include <iostream>
#include "ofColor.h"
#include "Creature.h"
#include "Herbivore.h"
#include "Plant.h"
#include "Carnivore.h"
#include "ofmain.h"
#include "Environment.h"



class EnvironmentRank : public Environment {
  
public:
    //method
    
    void setRank(int rank);
    int getRank();
    int ranking();
    bool update();
    bool live();
    void draw();
    bool beenUpdated(bool updated);
    
    
    
    //constructor
    Environment();
    
    bool live;
    int status;
    int rank;
    int subRank;
    
    int creatureNum;
    int herbivoreNum;
    int carnivoreNum;
    int plantNum;
    int compire;
    
    
    
    
    
    
private:
       
    
};

#endif 
#ifndef __Project2__EnvironmentRank__
#define __Project2__EnvironmentRank__

#define STANDARD 100

#include <iostream>
#include "ofColor.h"
#include "Creature.h"
#include "Herbivore.h"
#include "Plant.h"
#include "Carnivore.h"
#include "ofmain.h"
#include "Environment.h"



class EnvironmentRank : public Environment {
  
public:
    //method
    
    void setRank(int rank);
    int getRank();
    int ranking();
    bool update();
    bool live();
    void draw();
    bool beenUpdated(bool updated);
    
    
    
    //constructor
    Environment();
    
    bool live;
    int status;
    int rank;
    int subRank;
    
    int creatureNum;
    int herbivoreNum;
    int carnivoreNum;
    int plantNum;
    int compire;
    
    
    
    
    
    
private:
       
    
};

#endif 
