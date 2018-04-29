 //<>//

import netP5.*;
import oscP5.*;

 //<>// //<>//


import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;





Box2DProcessing box2d;


/***** VARIABLES *****/

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

SoundPad pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9, pad10;


//Initialize parameter wheels
ArrayList<Windmill> windmill;
ArrayList<Propeller> propeller;

//Key Press Logic 
boolean left, right, up, down; 

/***** SETUP *****/

void setup() {
  size(640,740);
  
  //Initialize box2d world with default settings
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(width, height));
  box2d.setGravity(0, 0); //set custom gravity
  //Turn on collision listening
  box2d.listenForCollisions();
  
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57121);
 
  smooth();
  frameRate(400);
   bg = loadImage("StartGame.png");
   bg2 = loadImage("GameScreen.png"); 
   
  
   pb = new Ball();
   pb2 = new Ball();
   pad1 = new SoundPad(width/8, 80, 10, 130);
   pad2 = new SoundPad(width/8, 230, 10, 130);
   pad3 = new SoundPad(width/8, 380, 10, 130);
   pad4 = new SoundPad(width/8, 530, 10, 130);
   
   pad5 = new SoundPad(width*0.845, 80, 10, 130);
   pad6 = new SoundPad(width*0.845, 230, 10, 130);
   pad7 = new SoundPad(width*0.845, 380, 10, 130);
   pad8 = new SoundPad(width*0.845, 530, 10, 130);
   
   pad9 = new SoundPad(width/5, height*0.945, 380, 10);
   pad10 = new SoundPad(width/5, height*0.044, 380, 10);


   
   boundaries = new ArrayList<Boundary>();
   
   //Floor boundary 
   boundaries.add(new Boundary(width/8, height*0.955, width*0.74, 2));
   //Ceiling Boundary
   boundaries.add(new Boundary(width/8, height*0.04, width*0.74, 2));
   //Left Boundary
   boundaries.add(new Boundary(width/8, 40, 2, height*0.9));
   //Right boundary
   boundaries.add(new Boundary(width*0.86, 40, 2, height*0.9));

   windmill = new ArrayList<Windmill>();
   
   windmill.add(new Windmill(new Vec2(175,150)));
   windmill.add(new Windmill(new Vec2(450,300)));
   windmill.add(new Windmill(new Vec2(175,450)));
   windmill.add(new Windmill(new Vec2(450,600)));
   
   propeller = new ArrayList<Propeller>();
   
   propeller.add(new Propeller(new Vec2(175,300)));
   propeller.add(new Propeller(new Vec2(450,150)));
   propeller.add(new Propeller(new Vec2(175,600)));
   propeller.add(new Propeller(new Vec2(450,450)));
   


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
  pad5.display();
  pad6.display();
  pad7.display();
  pad8.display();
  pad9.display();
  pad10.display();
  
  for (Windmill windmill : windmill) {
    windmill.display();
  }
   
   for (Propeller propeller : propeller) {
    propeller.display();
  }
  
  
  pb.display(255);
  pb2.display(50);
  
  
  
 
  


  
 //// Display all the boundaries
 // for (Boundary wall: boundaries) {
 //   wall.display();
 // }
 
  fill(255);
  text("framerate: " + (int)frameRate,12,16);

  

}


/*****KEY CONTROLS*****/

void keyPressed() {
    
  
  switch (keyCode) {
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
     OscMessage msg = new OscMessage("/starhit");
      osc.send(msg, supercollider);
    
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
  
  if (left == true){
     Vec2 impulse = new Vec2(5,0);
    pb2.applyLinearImpulse(impulse);
  }
  

    if (right == true){
    Vec2 impulse = new Vec2(-5,0);
    pb2.applyLinearImpulse(impulse);
  }
  
     if (up == true){
    Vec2 impulse = new Vec2(0,-5);
    pb2.applyLinearImpulse(impulse);
  }
  
   
  if (down == true){
    Vec2 impulse = new Vec2(0,5);
    pb2.applyLinearImpulse(impulse);
  }
}
  
  
void keyReleased() {
  
  switch (keyCode){
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


//void beginContact(Contact cp){
  
//  Fixture f1 = cp.getFixtureA();
//  Fixture f2 = cp.getFixtureB();
  
//  Body b1 = f1.getBody();
//  Body b2 = f2.getBody();
  
//  Ball e1 = (Ball) b1.getUserData();
//  SoundPad e2 = (SoundPad) b2.getUserData(); 
  
//  pad1.changeColor();
  
//  Object o1 = b1.getUserData();
//  if (o1.getClass() == SoundPad.class) {
//     SoundPad e = (SoundPad) o1;
//      pad1.changeColor();}

//}
