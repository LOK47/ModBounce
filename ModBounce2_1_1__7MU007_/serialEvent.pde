int[] serialInArray = new int[2];
int xVal, yVal;



void serialEvent(Serial myPort){

// read string from serial until new line
    String mpuValue = myPort.readStringUntil('\n');
    
// if value is not zero trim value, split and convert to integers

    if (mpuValue != null) {
     
      String mpuValue2 = trim(mpuValue);
      
      int [] vals = int(split(mpuValue2, ' '));
      
       xVal = vals[0];
       yVal = vals[1];

        // print the values (for debugging purposes only):
        println(xVal + "\t" + yVal + "\t");
      }
      
  }
  
void controller(){

       Vec2 impulse = new Vec2(xVal,yVal);
       pb.applyLinearImpulse(impulse);
       
       Vec2 impulse2 = new Vec2(yVal,xVal);
       cb1.applyLinearImpulse(impulse2);
       
       Vec2 impulse3 = new Vec2(xVal*-1,xVal*-1);
       cb2.applyLinearImpulse(impulse3);

       Vec2 impulse4 = new Vec2(yVal*-1,xVal*-1);
       cb3.applyLinearImpulse(impulse4);

}
