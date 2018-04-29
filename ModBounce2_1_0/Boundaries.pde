class Boundary {


  float x;
  float y;
  float w;
  float h;
  
  Body b;

  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

 // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w);
    float box2dH = box2d.scalarPixelsToWorld(h);
    
    sd.setAsBox(box2dW, box2dH);


 // Create body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attach the shape to the body
    b.createFixture(sd, 1);
    
    //b.setUserData(this);
  }

 // Draw the boundary
  void display() {
    stroke(255);
    rectMode(CORNER);
    rect(x,y,w,h);
  }

}
