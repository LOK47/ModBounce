class SoundPad {


  float x;
  float y;
  float w;
  float h;
  float c;
  
  Body b;

  SoundPad(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = 0;
    

 // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w+4);
    float box2dH = box2d.scalarPixelsToWorld(h+4);
    
    sd.setAsBox(box2dW, box2dH);


 // Create body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attach the shape to the body
    b.createFixture(sd, 1);
    
    b.setUserData(this);
  }

 // Draw the boundary
  void display() {
    
    fill(c);
    stroke(255);
    rectMode(CORNER);
    rect(x,y,w,h,2);
  }
  
  void changeColor(){
  c = #833434;
  }

}
