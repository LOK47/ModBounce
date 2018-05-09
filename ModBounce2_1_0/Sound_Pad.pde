class SoundPad {


  float x;
  float y;
  float w;
  float h;
  color col, col2;
  boolean pad_isON = false;
  
  Body b;

  SoundPad(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    col = 0;
    col2 = (255);

 // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    sd.setAsBox(box2dW, box2dH);


 // Create body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
// Define fixture + Attach the shape to the body
   FixtureDef fd = new FixtureDef();
   fd.shape = sd;

   
   fd.restitution = 3;
   b.createFixture(sd, 1);
    
    b.setUserData(this);
  }

 // Draw the boundary
  void display() {
    
    if (pad_isON == true) {col = color(#ff8f00);} 
    
    else {col = color(0);}
    
    fill(col, 125);
    stroke(col2, 125);
    rectMode(CENTER);
    rect(x,y,w,h,2);
  
  }

 void togglePad() {
   
     
   pad_isON = !pad_isON; //toggle pad yellow if pad_isON = true, black if false

}

public float gateToggle(){
  
  float gate;
  
  if (pad_isON) {gate = 1;}
  else {gate = 0;}
  
  return gate;

}

}
