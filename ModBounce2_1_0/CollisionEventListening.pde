
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1 == pad1 && o2.getClass() == Ball.class) {
    SoundPad pad1 = (SoundPad) o1;
    pad1.togglePad();
  
  } 
  

   
   if (o1 == pad2 && o2.getClass() == Ball.class) {
    SoundPad pad2 = (SoundPad) o1;
    pad2.togglePad();
    
  } 
  
 
  
     if (o1 == pad3 && o2.getClass() == Ball.class) {
    SoundPad pad3 = (SoundPad) o1;
    pad3.togglePad();
    
    //OscMessage msg3 = new OscMessage("/event3");
    //osc.send(msg3, supercollider);
  } 
  

  
   if (o1 == pad4 && o2.getClass() == Ball.class) {
    SoundPad pad4 = (SoundPad) o1;
    pad4.togglePad();
    
    //OscMessage msg4 = new OscMessage("/event4");
    //osc.send(msg4, supercollider);
  } 
  

 

     
     
   }
  


void endContact(Contact cp) {

  
  }
  
  
  
 
  
