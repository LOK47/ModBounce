class propellerWheel{
  
 Body body;
  float r;
  float a;
  float x, y;
  float w, h;

  
propellerWheel(Vec2 pos) {
  
  w = 50;
  h = 5;
  
  //Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(pos.x,pos.y));
  bd.angularVelocity = (random(-6, 6)); 
  //Create body
  body = box2d.world.createBody(bd); 
  
 
  //Create two rectangle shapes
  PolygonShape ps = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(w/1.8);
  float box2dH = box2d.scalarPixelsToWorld(h-1);
  ps.setAsBox(box2dW, box2dH);
  
  
  PolygonShape ps2 = new PolygonShape();
  float box2dW2 = box2d.scalarPixelsToWorld(h-1);
  float box2dH2 = box2d.scalarPixelsToWorld(w/1.7);
  ps2.setAsBox(box2dW2, box2dH2);
  
//Define + create fixture
  FixtureDef fd = new FixtureDef();
  //fd.shape = cs;
  fd.shape = ps;
  fd.shape = ps2;

// Physics parameters 

  fd.density = 2;
  fd.friction = 0.2;
  fd.restitution = 0.2;
  
//Attach fixture to body
  
  //body.createFixture(cs, 2.0);
  body.createFixture(ps, 2.0);
  body.createFixture(ps2, 2.0);
  
//Tell box2d to store this data in reference to this object
  body.setUserData(this);
 
  

}

void display(){
 
 Vec2 pos = new Vec2(box2d.getBodyPixelCoord(body));
  
 float a = body.getAngle();
  
  //shapeMode(CENTER);
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(-a);
  
  beginShape();
  fill(#434242);
  stroke(0);
  //Rectangle 1 (PolygonShape 1)
  rectMode(CENTER);
  rect(0,0,w,h,1.5);
  //Rectangle 2 (PolygonShape 2)
  rectMode(CENTER);
  rect(0,0,h,w,1.5);
  endShape();
  popMatrix();
  

}
}
