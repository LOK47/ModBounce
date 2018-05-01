
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
    pad1.changeColor();
    OscMessage msg = new OscMessage("/kickdrum");
    osc.send(msg, supercollider);} else {pad1.changeBack();}
   
   if (o1 == pad2 && o2.getClass() == Ball.class) {
    SoundPad pad2 = (SoundPad) o1;
    pad2.changeColor();} else {pad2.changeBack();}
    
   if (o1 == pad3 && o2.getClass() == Ball.class) {
    SoundPad pad3 = (SoundPad) o1;
    pad3.changeColor();}  else {pad3.changeBack();}
   
   if (o1 == pad4 && o2.getClass() == Ball.class) {
    SoundPad pad4 = (SoundPad) o1;
    pad4.changeColor();} else {pad4.changeBack();}
   
   if (o1 == pad5 && o2.getClass() == Ball.class) {
    SoundPad pad5 = (SoundPad) o1;
    pad5.changeColor();} else {pad5.changeBack();}
   
   if (o1 == pad6 && o2.getClass() == Ball.class) {
    SoundPad pad6 = (SoundPad) o1;
    pad6.changeColor();} else {pad6.changeBack();}
   
   if (o1 == pad7 && o2.getClass() == Ball.class) {
    SoundPad pad7 = (SoundPad) o1;
    pad7.changeColor();} else {pad7.changeBack();}
   
   if (o1 == pad8 && o2.getClass() == Ball.class) {
    SoundPad pad8 = (SoundPad) o1;
    pad8.changeColor();} else {pad8.changeBack();}
   
   if (o1 == pad9 && o2.getClass() == Ball.class) {
    SoundPad pad9 = (SoundPad) o1;
    pad9.changeColor();} else {pad9.changeBack();}
    
   if (o1 == pad10 && o2.getClass() == Ball.class) {
     SoundPad pad10 = (SoundPad) o1;
     pad10.changeColor();
     OscMessage msg = new OscMessage("/starhit");
     osc.send(msg, supercollider); } 
   else 
     {pad10.changeBack();}
    

   }
  
  

void endContact(Contact cp) {

    //pad1.changeBack();
    //pad2.changeBack();
    //pad3.changeBack();
    //pad4.changeBack();
    //pad5.changeBack();
    //pad6.changeBack();
    //pad7.changeBack();
    //pad8.changeBack();
    //pad9.changeBack();
    //pad10.changeBack();
  }
  
