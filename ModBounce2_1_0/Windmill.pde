class Windmill {

  // Our object is two boxes and one joint
  // Consider making the fixed box much smaller and not drawing it
  RevoluteJoint joint;
  GreenWheel wheel;
  WheelAnchor anchor;

  Windmill(Vec2 pos) {

    // Initialize locations of two boxes
    wheel = new GreenWheel(pos); 
    anchor = new WheelAnchor(pos); 

    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();
   

    rjd.initialize(wheel.body, anchor.body, anchor.body.getWorldCenter());
    rjd.enableLimit = true;
    rjd.lowerAngle = box2d.scalarPixelsToWorld(0.0);
    rjd.upperAngle = box2d.scalarPixelsToWorld(47.0);
    

      // Create the joint
    joint = (RevoluteJoint) box2d.world.createJoint(rjd);
  }



  void display() {
    wheel.display();
    anchor.display();

 // Draw anchor just for debug
  Vec2 bolt = box2d.coordWorldToPixels(anchor.body.getWorldCenter());
  
  noStroke();
  fill(0);
  ellipseMode(CENTER);
  ellipse(bolt.x, bolt.y, 6, 6);
  endShape();
  
  }
 
public float getAngle(){

 float a = wheel.body.getAngle(); 
 map(a, 0.0, 47.0, 0, 1  );
 
return a;
}
  
  
}
