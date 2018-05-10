class chaosBall {

 Body b;

float r;
float c;

Vec2 velocity;
Vec2 pos;

//Constructor
chaosBall() {
  
  makeBody();
  r = 12;
}


void display() {
  
  Vec2 pos = box2d.getBodyPixelCoord(b);
  
  
  fill(random(0,255), random(0,255), random(0,255), 100);
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
  fd.restitution = 1;
  
//Attach fixture to body
  
  b.createFixture(fd);
  
 
  
//Tell box2d to store this data in reference to this object
  b.setUserData(this);
 
}

void applyLinearImpulse(Vec2 impulse){
  
  Vec2 pos = b.getWorldCenter(); 
  
  b.applyLinearImpulse(impulse, pos, true);
  
}

 
}
