class WheelAnchor{
  
 Body body;
  float r;
  float a;
  float x, y;
  float w, h;
 
  
WheelAnchor(Vec2 pos) {
  
  r = 20;
  w = 50;
  h = 10;
  
  //Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.STATIC;
  bd.position.set(box2d.coordPixelsToWorld(pos.x,pos.y));
 
//Create body
  body = box2d.world.createBody(bd); 

//Create wheel shape using circle + 2 rectangles;
  CircleShape cs = new CircleShape();
  cs.m_radius = box2d.scalarPixelsToWorld(r/1.5);
  
 
//Define + create fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = cs;

// Physics parameters 

  fd.density = 2;
  fd.friction = 0.2;
  fd.restitution = 0.2;
  
//Attach fixture to body
  
  body.createFixture(cs, 2.0);
  
//Tell box2d to store this data in reference to this object

  body.setUserData(this);
 
  

}

void display(color col){
 
 Vec2 pos = new Vec2(box2d.getBodyPixelCoord(body));
 float a = body.getAngle();
   
  //shapeMode(CENTER);
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(-a);
  noFill();
  strokeWeight(1.2);
  stroke(col, 150);
  
  //Center CircleShape
  ellipseMode(CENTER);
  ellipse(0, 0, r, r);
  popMatrix();

}


}
