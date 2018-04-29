class Ball {

 Body ball;

float r;
float c;

Vec2 velocity;
Vec2 pos;

//Constructor
Ball() {
  
  makeBody();
  ball.setUserData(this);
  r = 12;
}


void display(float c) {
  
  Vec2 pos = box2d.getBodyPixelCoord(ball);
  
  
  fill(c); //<>//
  stroke(c);
  ellipse(pos.x ,pos.y , r, r);
 
}

//void update(){
//  //pos.add(velocity);
  
//  if (pos.x > width/8){
  
//  velocity = new Vec2(1,0); //<>//
// }

//}

void makeBody(){
//Starting position in box2d vector
  Vec2 pos = box2d.coordPixelsToWorld(width/2, height/2);
  
//Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
 // body.setFixedRotation(false);
  bd.position.set(pos);
  bd.bullet = true;
  bd.linearDamping = 0.5;
  
  
//Create body
  ball = box2d.world.createBody(bd); 

//Create shape
  CircleShape cs = new CircleShape();
  cs.m_radius = box2d.scalarPixelsToWorld(r);
  
//Define + create fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = cs;

// Physics parameters 

  fd.density = 0.5;
  fd.friction = 0.2;
  fd.restitution = 1.2;
  
//Attach fixture to body
  
  ball.createFixture(fd);
  
//Tell box2d to store this data in reference to this object
  ball.setUserData(this);
 
}

void applyLinearImpulse(Vec2 impulse){
  
  Vec2 pos = ball.getWorldCenter(); 
  
  ball.applyLinearImpulse(impulse, pos, true);
  
}
}
