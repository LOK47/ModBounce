void mapParameters(){

  OscMessage msg = new OscMessage("/pad1GATE");
  msg.add(pad1.gateToggle());
  osc.send(msg, supercollider);
  
  OscMessage msg2 = new OscMessage("/pad1FREQ");
  msg2.add(map(rMod1.getAngle(),0, 6, 200, 800));
  osc.send(msg2, supercollider);
  
  OscMessage msg3 = new OscMessage("/pad1DETUNE");
  msg3.add(map(yMod1.getAngle(),0, 6, 0, 12));
  osc.send(msg3, supercollider);
  
  OscMessage msg4 = new OscMessage("/pad1HARMONICS");
  msg4.add(map(gMod1.getAngle(),0, 6, 0, 1));
  osc.send(msg4, supercollider);
  
  if (pad2.gateToggle() == 1){
  OscMessage msg5 = new OscMessage("/pad2OPENGATE");
  osc.send(msg5, supercollider);
  } 
  
  if (pad2.gateToggle() == 0){
  OscMessage msg6 = new OscMessage("/pad2CLOSEGATE");
  osc.send(msg6, supercollider);}
  

}
