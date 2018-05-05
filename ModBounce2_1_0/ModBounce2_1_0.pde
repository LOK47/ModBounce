 //<>// //<>//

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
 

/***** VARIABLES *****/

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
Ball pb, pb2;

//Array list for all boundaries
ArrayList<Boundary> boundaries;

//Initialize sound pads
SoundPad pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9, pad10;


//Initialize parameter wheels
Windmill wm1, wm2, wm3, wm4;

//ArrayList<Windmill> windmill;
ArrayList<Propeller> propeller;

//Key Press Logic 
boolean left, right, up, down, space; 

/***** SETUP *****/

void setup() {
  size(640,740);
  
  //Initialize box2d world with default settings
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0); //set custom gravity
  
  //Turn on collision listening
  box2d.listenForCollisions();
  
  
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
 
  smooth();
  frameRate(400);
   bg = loadImage("StartGame.png");
   bg2 = loadImage("GameScreen.png"); 
   
  //Player balls
   pb = new Ball();
   //pb2 = new Ball();
   
   
   //Soundpads
   
   pad1 = new SoundPad(width/5, height*0.044, 380, 10);
   
   pad2 = new SoundPad(width/8, height/4, 10, 380);
   
   pad3 = new SoundPad(width/5, height*0.945, 380, 10);
   
   pad4 = new SoundPad(width*0.845, height/4, 10, 380);
    
   //pad1 = new SoundPad(width/8, 80, 10, 130);
 
   //pad3 = new SoundPad(width/8, 380, 10, 130);
   //pad4 = new SoundPad(width/8, 530, 10, 130);
   
   //pad5 = new SoundPad(width*0.845, 80, 10, 130);
   //pad6 = new SoundPad(width*0.845, 230, 10, 130);
   //pad7 = new SoundPad(width*0.845, 380, 10, 130);
   //pad8 = new SoundPad(width*0.845, 530, 10, 130);
   

  


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

   //Pad Parameter Windmills
   wm1 = new Windmill(new Vec2(width/2,150));
   wm2 = new Windmill(new Vec2(450,height/2));
   wm3 = new Windmill(new Vec2(width/2,600));
   wm4 = new Windmill(new Vec2(175,height/2));
  
  
   //Obstacle propellers 
   propeller = new ArrayList<Propeller>();
   
   propeller.add(new Propeller(new Vec2(175,150)));
   propeller.add(new Propeller(new Vec2(450,150)));
   propeller.add(new Propeller(new Vec2(175,600)));
   propeller.add(new Propeller(new Vec2(450,600)));

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
  //pad5.display();
  //pad6.display();
  //pad7.display();
  //pad8.display();
  //pad9.display();
  //pad10.display();
  
  wm1.display();
  wm2.display();
  wm3.display();
  wm4.display();
  
   
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
  
  if (space == true) {
     OscMessage msgX = new OscMessage("/eventX");
     osc.send(msgX, supercollider);
  
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
