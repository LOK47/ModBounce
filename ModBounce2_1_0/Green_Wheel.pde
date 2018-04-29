class GreenWheel{
  
 Body body;
  float r;
  float a;
  float x, y;
  float w, h;

  
GreenWheel(Vec2 pos) {
  
  r = 30;
  w = 100;
  h = 10;
  
  //Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(pos.x,pos.y));
  bd.angularDamping = 0.2; 
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

  fd.density = 1;
  fd.friction = 0.2;
  fd.restitution = 0;
  
//Attach fixture to body
  
  //body.createFixture(cs, 2.0);
  body.createFixture(ps, 0.5);
  body.createFixture(ps2, 0.5);
  
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
  fill(#427b4e);
  stroke(0);
  //Rectangle 1 (PolygonShape 1)
  rectMode(CENTER);
  rect(0,0,w,h,3);
  //Rectangle 2 (PolygonShape 2)
  rectMode(CENTER);
  rect(0,0,h,w,3);
  //Red marker lines 
  stroke(#902222);
  line(-35,-4,-35,4);
  line(-38,-4,-38,4);
  endShape();
  popMatrix();
  

}
}
