 //<>// Import Libraries  //<>// //<>//
 //<>//

import netP5.*;
import oscP5.*;
import processing.serial.*; //<>//
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
 

//<>// GLOBAL VARIABLES //<>// //<>//
Serial myPort;     // The serial port

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

//Array list for all boundaries
ArrayList<Boundary> boundaries;

//ArrayList for chaos balls
ArrayList<chaosBall> tb;

//ArrayList for Propellers 
ArrayList<Propeller> propeller;

//Initialize player ball 
Ball pb;

//Initialize chaos balls
chaosBall cb1, cb2, cb3;

//Initialize sound pads
SoundPad pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9, pad10;

//Initialize parameter wheels
greenMod gMod1, gMod2, gMod3, gMod4;
yellowMod yMod1, yMod2, yMod3, yMod4;
redMod rMod1, rMod2, rMod3, rMod4;

//Initialize bumpers
Bumper bump1, bump2, bump3, bump4;

//Initilize mixer faders
VScrollbar vs1, vs2, vs3, vs4;


//Key Press Logic 
boolean left, right, up, down, space, tab; 


//<>// SETUP //<>// //<>//

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
  
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 115200);
 
  smooth(4);
  frameRate(400);
  bg = loadImage("modbounce_start.png");
  bg2 = loadImage("modbounce_gamescreen.png"); 
   
/***** BALLS *****/

   //Player ball
   pb = new Ball();
   
   //Shadow balls
   cb1 = new chaosBall();
   cb2 = new chaosBall();
   cb3 = new chaosBall();
   
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
   yMod1 = new yellowMod(new Vec2(280,140));
   rMod1 = new redMod(new Vec2(230,190));
   gMod1 = new greenMod(new Vec2(180,240));
   
   yMod2 = new yellowMod(new Vec2(280, 600));
   rMod2 = new redMod(new Vec2(230, 550));
   gMod2 = new greenMod(new Vec2(180, 500));
   
   yMod3 = new yellowMod(new Vec2(350, 600));
   rMod3 = new redMod(new Vec2(400, 550));
   gMod3 = new greenMod(new Vec2(450, 500));
   
   yMod4 = new yellowMod(new Vec2(350, 140));
   rMod4 = new redMod(new Vec2(400, 190));
   gMod4 = new greenMod(new Vec2(450, 240));
   
   //Bumpers
   bump1 = new Bumper(new Vec2(200, 615), 10, 200, 7.1);
   bump2 = new Bumper(new Vec2(430, 615), 10, 200, -7.1);
   bump3 = new Bumper(new Vec2(200, 125), 10, 200, -7.1);
   bump4 = new Bumper(new Vec2(430, 125), 10, 200, 7.1);
  
  
   //Obstacle propellers 
   propeller = new ArrayList<Propeller>();
   
   propeller.add(new Propeller(new Vec2(180,height/2)));
   propeller.add(new Propeller(new Vec2(450,height/2)));
   propeller.add(new Propeller(new Vec2(width/2,240)));
   propeller.add(new Propeller(new Vec2(width/2,500)));
   
   //Mixer faders
   vs1 = new VScrollbar(167, 300, 50, 400, 5);
   vs2 = new VScrollbar(267, 300, 50, 400, 5);
   vs3 = new VScrollbar(367, 300, 50, 400, 5);
   vs4 = new VScrollbar(467, 300, 50, 400, 5);
    
}

/***** DRAW *****/

void draw() {
  
  //tell box2dto step to next moment in time
  
  box2d.step();
 
  //Change screens according to mouse/key input values 
  
  if (gameScreen == 0) {
    intScreen();
  } else if (gameScreen == 1) {
    gameScreen();  
  } 
  
   if (space == true){
  mixerScreen();
  } 
  
  //Update volume slider position
  vs1.update();
  vs2.update();
  vs3.update();
  vs4.update();
  
}


void intScreen() {
  background(bg);
}


void gameScreen() {
  
  background(bg2);
  
  //Display soundpads
  pad1.display();
  pad2.display();
  pad3.display();
  pad4.display();
  
  //Display modwheels
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
  
  //Display balls
  pb.display(255);
  cb1.display();
  cb2.display();
  cb3.display();
  
  //Display Bumpers
  bump1.display();
  bump2.display();
  bump3.display();
  bump4.display();
  
  //Display propellers
  for (Propeller propeller : propeller){
  propeller.display();
}
  
  mapParameters();
  serialEvent(myPort);
  controller();
 

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
    
    case 9:
    tab = true;
    break;
    
  }
  
//Player ball controls

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
  
//Chaos Ball (1) controls
    if (left == true){
    Vec2 impulse = new Vec2(-3,0);
    cb1.applyLinearImpulse(impulse);  
  }
    if (right == true){
    Vec2 impulse = new Vec2(-3,0);
    cb1.applyLinearImpulse(impulse);
  }
     if (up == true){
    Vec2 impulse = new Vec2(0,-3);
    cb1.applyLinearImpulse(impulse);
  }
  if (down == true){
    Vec2 impulse = new Vec2(0,3);
    cb1.applyLinearImpulse(impulse);
  }
 
//Chaos Ball (2) controls
    if (left == true){
    Vec2 impulse = new Vec2(0,3);
    cb2.applyLinearImpulse(impulse);  
  }
    if ( right == true){
    Vec2 impulse = new Vec2(0,-3);
    cb2.applyLinearImpulse(impulse);
  }
     if (up == true){
    Vec2 impulse = new Vec2(-3,0);
    cb2.applyLinearImpulse(impulse);
  }
  if (down == true){
    Vec2 impulse = new Vec2(3,0);
    cb2.applyLinearImpulse(impulse);
  }
  
//Chaos Ball (3) controls
    if (left == true){
    Vec2 impulse = new Vec2(0,-3);
    cb3.applyLinearImpulse(impulse);  
  }
    if ( right == true){
    Vec2 impulse = new Vec2(0,3);
    cb3.applyLinearImpulse(impulse);
  }
     if (up == true){
    Vec2 impulse = new Vec2(3,0);
    cb3.applyLinearImpulse(impulse);
  }
  if (down == true){
    Vec2 impulse = new Vec2(-3,0);
    cb3.applyLinearImpulse(impulse);
  }
  
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
    
    case 9:
    tab = false;
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
