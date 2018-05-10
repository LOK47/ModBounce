void mapParameters(){

  //***** PAD 1 *****//
  
  OscMessage msg = new OscMessage("/pad1GATE");
  msg.add(pad1.gateToggle());
  osc.send(msg, supercollider);
  
  OscMessage msg2 = new OscMessage("/pad1FREQ");
  msg2.add(map(rMod1.getAngle(),-0, -6, 40, 300));
  osc.send(msg2, supercollider);
  
  OscMessage msg3 = new OscMessage("/pad1DETUNE");
  msg3.add(map(yMod1.getAngle(),-0, -6, 0, 12));
  osc.send(msg3, supercollider);
  
  OscMessage msg4 = new OscMessage("/pad1HARMONICS");
  msg4.add(map(gMod1.getAngle(),-0, -6, 1, 50));
  osc.send(msg4, supercollider);
  
   //***** PAD 2 *****//
   
  if (pad2.gateToggle() == 1){
  OscMessage msg5 = new OscMessage("/pad2OPENGATE");
  osc.send(msg5, supercollider);
  } 
  
  if (pad2.gateToggle() == 0){
  OscMessage msg6 = new OscMessage("/pad2CLOSEGATE");
  osc.send(msg6, supercollider);}
  
  OscMessage msg7 = new OscMessage("/pad2TRANSPOSE");
  msg7.add(map(gMod2.getAngle(),-0, -6, -12, 12));
  osc.send(msg7, supercollider);
  
  OscMessage msg8 = new OscMessage("/pad2STRETCH");
  msg8.add(map(yMod2.getAngle(),-0, -6, 0.5, 2));
  osc.send(msg8, supercollider);
  
  OscMessage msg9 = new OscMessage("/pad2DETUNE");
  msg9.add(map(rMod2.getAngle(), -0, -6, 0, 10));
  osc.send(msg9, supercollider);
  
   //***** PAD 3 *****//
   
   if (pad3.gateToggle() == 1){
  OscMessage msg10 = new OscMessage("/pad3OPENGATE");
  osc.send(msg10, supercollider);
  } 
  
  if (pad3.gateToggle() == 0){
  OscMessage msg11 = new OscMessage("/pad3CLOSEGATE");
  osc.send(msg11, supercollider);}
  
  OscMessage msg12 = new OscMessage("/pad3NOTE");
  msg12.add(map(gMod3.getAngle(),-0, -6, 0, 20));
  osc.send(msg12, supercollider);
  
  OscMessage msg13 = new OscMessage("/pad3DETUNE");
  msg13.add(map(yMod3.getAngle(),-0, -6, 0, 12));
  osc.send(msg13, supercollider);
  
  OscMessage msg14 = new OscMessage("/pad3DURATION");
  msg14.add(map(rMod3.getAngle(), -0, -6, 1, 16));
  osc.send(msg14, supercollider);
   
   //***** PAD 4 *****//
   
   if (pad4.gateToggle() == 1){
  OscMessage msg15 = new OscMessage("/pad4OPENGATE");
  osc.send(msg15, supercollider);
  } 
  
  if (pad4.gateToggle() == 0){
  OscMessage msg16 = new OscMessage("/pad4CLOSEGATE");
  osc.send(msg16, supercollider);}
  
  OscMessage msg17 = new OscMessage("/pad4RATE");
  msg17.add(map(gMod4.getAngle(),-0, -6, 0.2, 2));
  osc.send(msg17, supercollider);
  
  OscMessage msg18 = new OscMessage("/pad4STRETCH");
  msg18.add(map(yMod4.getAngle(),-0, -6, 0.5, 2 ));
  osc.send(msg18, supercollider);
  
  OscMessage msg19 = new OscMessage("/pad4DURATION");
  msg19.add(map(rMod4.getAngle(), -0, -6, 1, 16));
  osc.send(msg19, supercollider);
   
   //***** Mixer Mapping *****//
   
  OscMessage msg20 = new OscMessage("/pad1AMP");
  msg20.add(map(vs1.getPos(),700, 300, 0, 1));
  osc.send(msg20, supercollider);
  
  OscMessage msg21 = new OscMessage("/pad2AMP");
  msg21.add(map(vs2.getPos(),700, 300, 0, 1));
  osc.send(msg21, supercollider);
  
  OscMessage msg22 = new OscMessage("/pad3AMP");
  msg22.add(map(vs3.getPos(),700, 300, 0, 1));
  osc.send(msg22, supercollider);
  
  OscMessage msg23 = new OscMessage("/pad4AMP");
  msg23.add(map(vs4.getPos(),700, 300, 0, 1));
  osc.send(msg23, supercollider);

}
