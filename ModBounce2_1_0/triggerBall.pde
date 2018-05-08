class triggerBall {

 Body b;

float r;
float c;

Vec2 velocity;
Vec2 pos;

//Constructor
triggerBall() {
  
  makeBody();
  r = 12;
}


void displayPink() {
  
  Vec2 pos = box2d.getBodyPixelCoord(b);
  
  
  fill(#f44271);
  noStroke();
  ellipse(pos.x ,pos.y , r, r);
 
}


void makeBody(){
//Starting position in box2d vector
  Vec2 pos = box2d.coordPixelsToWorld(width/2, height/2);
  
//Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(pos);
  bd.bullet = true;
  bd.linearDamping = 0.5;
  
  //b.setAngularVelocity(random(-10, 10));
  
  
//Create body
  b = box2d.world.createBody(bd); 

//Create shape
  CircleShape cs = new CircleShape();
  cs.m_radius = box2d.scalarPixelsToWorld(r);
  
//Define + create fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = cs;

// Physics parameters 

  fd.density = 1;
  fd.friction = 0.2;
  fd.restitution = 1.2;
  
//Attach fixture to body
  
  b.createFixture(fd);
  
 
  
//Tell box2d to store this data in reference to this object
  b.setUserData(this);
 
}

//void applyForce(Vec2 force, Vec2 point){
  
// Vec2 pos = b.getWorldCenter(); 
  
// point = pos;
 
// }
 
}
