 //<>// //<>//
 //<>//

import netP5.*;
import oscP5.*;

 //<>//
 
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
 

 //<>// GLOBAL VARIABLES  //<>//

Box2DProcessing box2d;

OscP5 osc;
NetAddress supercollider;

//LOAD BACKGROUND IMAGES
PImage bg;
PImage bg2;

//Activate screens by updating gameScreen variable
// 0 : initial screen
// 1 : Game Screen

int gameScreen = 0;

//Initialize player ball 
Ball pb;

//Initialize trigger balls
triggerBall tb1, tb2, tb3, tb4;

//Array list for all boundaries
ArrayList<Boundary> boundaries;

//Initialize sound pads
SoundPad pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9, pad10;

//Initialize parameter wheels
greenMod gMod1, gMod2, gMod3, gMod4;
yellowMod yMod1, yMod2, yMod3, yMod4;
redMod rMod1, rMod2, rMod3, rMod4;




//ArrayList for Propellers 
ArrayList<Propeller> propeller;

//Key Press Logic 
boolean left, right, up, down, space; 

 //<>// SETUP //<>//

void setup() {
  size(640,740);
  
  //Initialize box2d world with default settings
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0); //set custom gravity
  box2d.listenForCollisions(); //Turn on collision listening
  
  //Initialize OSC ports
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
 
  smooth();
  frameRate(400);
  bg = loadImage("modbounce_start.png");
  bg2 = loadImage("modbounce_gamescreen.png"); 
   
  //Player balls
   pb = new Ball();
 //pb2 = new Ball();
   
    /***** BALLS *****/
   
   tb1 = new triggerBall();
  
   
   /***** SOUNDPADS *****/
   
   pad1 = new SoundPad(width/2, height*0.05, 380, 10);
   
   pad2 = new SoundPad(width/7.5, height/2, 10, 380);
   
   pad3 = new SoundPad(width/2, height*0.95, 380, 10);
   
   pad4 = new SoundPad(width*0.85, height/2, 10, 380);
    

   //Create empty array for Boundaries
   boundaries = new ArrayList<Boundary>();
   
   //Floor boundary 
   boundaries.add(new Boundary(width/8, height*0.955, width*0.74, 2));
   //Ceiling Boundary
   boundaries.add(new Boundary(width/8, height*0.04, width*0.74, 2));
   //Left Boundary
   boundaries.add(new Boundary(width/8, 40, 2, height*0.9));
   //Right boundary
   boundaries.add(new Boundary(width*0.86, 40, 2, height*0.9));

   //Parameter Modwheels
   yMod1 = new yellowMod(new Vec2(width/3,125));
   rMod1 = new redMod(new Vec2(width/1.99,125));
   gMod1 = new greenMod(new Vec2(426,125));
   
      
   yMod2 = new yellowMod(new Vec2(width/4, 493));
   rMod2 = new redMod(new Vec2(width/4, height/2));
   gMod2 = new greenMod(new Vec2(width/4, height/3));
   
   yMod3 = new yellowMod(new Vec2(426, 625));
   rMod3 = new redMod(new Vec2(width/1.99, 625));
   gMod3 = new greenMod(new Vec2(width/3, 625));
   
   yMod4 = new yellowMod(new Vec2(475, height/3));
   rMod4 = new redMod(new Vec2(475, height/2));
   gMod4 = new greenMod(new Vec2(475, 493));
  
  
   //Obstacle propellers 
   propeller = new ArrayList<Propeller>();
   
   propeller.add(new Propeller(new Vec2(220,310)));
   propeller.add(new Propeller(new Vec2(220,430)));
   propeller.add(new Propeller(new Vec2(400,310)));
   propeller.add(new Propeller(new Vec2(400,430)));
   propeller.add(new Propeller(new Vec2(width/2,250)));
   propeller.add(new Propeller(new Vec2(width/2,500)));
    
}

/***** DRAW *****/

void draw() {
  
  //tell box2dto step to next moment in time
  
  box2d.step();
 
  //Listen to mouse-clicks and only switch to gameplay screen when screen is clicked
  
  if (gameScreen == 0) {
    intScreen();
  } else if (gameScreen == 1) {
    gameScreen();
     
  } 
 
}


void intScreen() {
  background(bg);
}


void gameScreen() {
  
  background(bg2);
  
  pad1.display();
  pad2.display();
  pad3.display();
  pad4.display();
  
  // Modwheel display
  
  gMod1.display();
  yMod1.display();
  rMod1.display();
  
  yMod2.display();
  rMod2.display();
  gMod2.display();
  
  yMod3.display();
  rMod3.display();
  gMod3.display();
  
  gMod4.display();
  yMod4.display();
  rMod4.display();
  
 
  mapParameters();
  
  tb1.displayPink();

  
   
   for (Propeller propeller : propeller) {
    propeller.display();
  }
  
  
  pb.display(255);
  //pb2.display(50);

 
  fill(255);
  text("framerate: " + (int)frameRate,12,16);

}


/*****KEY CONTROLS*****/

void keyPressed() {
    
  
  switch (keyCode) {
    
    case 32:
    space = true;
    break;
    
    case 37:
    left = true;
     break;
    
    case 38:
    up = true;
    break;
      
    case 39: 
    right = true;
    break;
    
    case 40: 
    down = true;
    break;
    
  }
  
//Main ball controls
  if (left == true){
    Vec2 impulse = new Vec2(-5,0);
    pb.applyLinearImpulse(impulse);   
  }
  
    if (right == true){
    Vec2 impulse = new Vec2(5,0);
    pb.applyLinearImpulse(impulse);
  }
    if (up == true){
    Vec2 impulse = new Vec2(0,5);
    pb.applyLinearImpulse(impulse);
  }
   if (down == true){
    Vec2 impulse = new Vec2(0,-5);
    pb.applyLinearImpulse(impulse);
  }
  
 
//Shadow Ball (1) controls
  
  //if (left == true){
  //   Vec2 impulse = new Vec2(5,0);
  //  pb2.applyLinearImpulse(impulse);
  //}
  

  //  if (right == true){
  //  Vec2 impulse = new Vec2(-5,0);
  //  pb2.applyLinearImpulse(impulse);
  //}
  
  //   if (up == true){
  //  Vec2 impulse = new Vec2(0,-5);
  //  pb2.applyLinearImpulse(impulse);
  //}
  
   
  //if (down == true){
  //  Vec2 impulse = new Vec2(0,5);
  //  pb2.applyLinearImpulse(impulse);
  //}
  
  //Stop all sound
  
}
  
  
void keyReleased() {
  
  switch (keyCode){
    
    case 32:
    space = false;
    break;
    
    case 37:
    left = false;
    break;
    
    case 38:
    up = false;
    break;
    
    case 39:
    right = false;
    break;
    
    case 40:
    down = false;
    break;
  }
}



     
public void mousePressed() {
  if (gameScreen==0) {
    startGame();
  }
}
  
void startGame() {
  gameScreen = 1;
}
