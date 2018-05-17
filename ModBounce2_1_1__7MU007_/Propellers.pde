class Propeller {

  // Two boxes and one joint
  RevoluteJoint joint;
  propellerWheel wheel;
  propellerAnchor anchor;

  Propeller(Vec2 pos) {

    // Initialize locations of two boxes
    wheel = new propellerWheel(pos); 
    anchor = new propellerAnchor(pos); 

    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(wheel.body, anchor.body, anchor.body.getWorldCenter());


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
