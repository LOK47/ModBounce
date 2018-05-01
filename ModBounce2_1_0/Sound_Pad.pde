class SoundPad {


  float x;
  float y;
  float w;
  float h;
  color col, col2;
  
  Body b;

  SoundPad(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    col = 0;
    col2 = (#6F8F7C);

 // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w+4);
    float box2dH = box2d.scalarPixelsToWorld(h*0.9);
    
    sd.setAsBox(box2dW, box2dH);


 // Create body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
// Define fixture + Attach the shape to the body
   FixtureDef fd = new FixtureDef();
   fd.shape = sd;

   
   fd.restitution = 1.2;
   b.createFixture(sd, 1);
    
    b.setUserData(this);
  }

 // Draw the boundary
  void display() {
    
    fill(col);
    stroke(col2);
    rectMode(CORNER);
    rect(x,y,w,h,2);
  }
  
  void changeColor(){
  col = color(#FFC133);
  //col = color(#F9E79F);
  col2 = (0);
  }
  
  void changeBack(){
  col = color(0);
  col2 = (#6F8F7C);
  
  }

}
