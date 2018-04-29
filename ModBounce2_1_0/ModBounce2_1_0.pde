 //<>// //<>// //<>//


import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;





Box2DProcessing box2d;


/***** VARIABLES *****/

//LOAD BACKGROUND IMAGES
PImage bg;
PImage bg2;

//Activate screens by updating gameScreen variable
// 0 : initial screen
// 1 : Game Screen

int gameScreen = 0;

//Initialize player ball 
Ball b, b2;

//Array list for all boundaries
ArrayList<Boundary> boundaries;


//Initialize parameter wheels
ArrayList<Windmill> windmill;
ArrayList<Propeller> propeller;





boolean left, right, up, down; 

/***** SETUP *****/

void setup() {
  size(640,740);
  
  //Initialize box2d world with default settings
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0); //set custom gravity


  
 
  smooth();
  frameRate(400);
   bg = loadImage("StartGame.png");
   bg2 = loadImage("GameScreen.png"); 
   
  // Gwheel = loadShape("cogwheel.svg");
   b = new Ball();
   b2 = new Ball();

   
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
  
  for (Windmill windmill : windmill) {
    
    windmill.display();
  }
   
   for (Propeller propeller : propeller) {
    
    propeller.display();
  }
  
  b.display(255);
  b2.display(50);
  


  
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
  
  if (left == true){
    Vec2 impulse = new Vec2(-5,0);
    b.applyLinearImpulse(impulse);
  }
  
  if (left == true){
     Vec2 impulse = new Vec2(5,0);
    b2.applyLinearImpulse(impulse);
  }
  
  if (right == true){
    Vec2 impulse = new Vec2(5,0);
    b.applyLinearImpulse(impulse);
  }
    if (right == true){
    Vec2 impulse = new Vec2(-5,0);
    b2.applyLinearImpulse(impulse);
  }
    if (up == true){
    Vec2 impulse = new Vec2(0,5);
    b.applyLinearImpulse(impulse);
  }
     if (up == true){
    Vec2 impulse = new Vec2(0,-5);
    b2.applyLinearImpulse(impulse);
  }
  
    if (down == true){
    Vec2 impulse = new Vec2(0,-5);
    b.applyLinearImpulse(impulse);
  }
  if (down == true){
    Vec2 impulse = new Vec2(0,5);
    b2.applyLinearImpulse(impulse);
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
