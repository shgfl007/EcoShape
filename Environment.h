//
//  Environment.h
//  Project2
//
//  Created by Digital Media Lab User on 13-03-10.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef Project2_Environment_h
#define Project2_Environment_h


class Environment{
  
public:
    //method
    
    void setRank(int);
    void getRank(int);
    int ranking();
    bool update();
    void draw();
    bool beenUpdated(bool updated);
    
    
    
    //constructor
    Environment();
    
    bool live;
    int rank;
   	bool beenUpdated;
   	
    
    
    
    
    
    
private:
   
    
    
};
#endif
