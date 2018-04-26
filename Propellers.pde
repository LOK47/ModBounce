class Propeller {

  // Our object is two boxes and one joint
  // Consider making the fixed box much smaller and not drawing it
  RevoluteJoint joint;
  GreyWheel wheel;
  PropellerAnchor anchor;

  Propeller(Vec2 pos) {

    // Initialize locations of two boxes
    wheel = new GreyWheel(pos); 
    anchor = new PropellerAnchor(pos); 

    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(wheel.body, anchor.body, anchor.body.getWorldCenter());



    // There are many other properties you can set for a Revolute joint
    // For example, you can limit its angle between a minimum and a maximum
    // See box2d manual for more

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
}
