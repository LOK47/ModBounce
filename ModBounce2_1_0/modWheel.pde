class modWheel{
  
 Body body;
  float r;
  float a;
  float x, y;
  float w, h;

  modWheel(Vec2 pos) {
  
  r = 15;
  w = 80;
  h = 10;
  
  
  //Define body 
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(pos.x,pos.y));
  bd.angularDamping = 0.5; 
  bd.allowSleep = true;
  //Create body
  body = box2d.world.createBody(bd); 
  
 
  //Create two rectangle shapes
  PolygonShape ps = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(w/2.8);
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

  fd.density = 0.5;
  fd.friction = 1;
  fd.restitution = 0;
  
//Attach fixture to body
  
  //body.createFixture(cs, 2.0);
  body.createFixture(ps, 0.5);
  body.createFixture(ps2, 0.5);
  
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
  
  beginShape();
  fill(col, 125);
  stroke(0);
  //Rectangle 1 (PolygonShape 1)
  rectMode(CENTER);
  rect(0,0,w/2,h,3);
  //Rectangle 2 (PolygonShape 2)
  rectMode(CENTER);
  rect(0,0,h,w,3);
  //Red marker lines 
  stroke(200);
  line(-24,-4,-24,4);
  line(-27,-4,-27,4);
  endShape();
  popMatrix();

}

  
}
