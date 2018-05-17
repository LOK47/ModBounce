class Bumper{

  Vec2 pos;
  float w;
  float h;
  float r;
  
  Body b;

  Bumper(Vec2 pos, float w_, float h_, float r_) {
 
    w = w_;
    h = h_;
    r = r_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(pos));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary
  void display() {
    
  Vec2 pos = new Vec2(box2d.getBodyPixelCoord(b));
  
    float a = b.getAngle();
    b.setTransform(b.getPosition(), r);
  
    pushMatrix();
    translate(pos.x, pos.y);
    fill(100, 100);
    stroke(0);
    rotate(-a);
    rectMode(CENTER);
    rect(0,0,w,h, 3);
    popMatrix();
  }

}
