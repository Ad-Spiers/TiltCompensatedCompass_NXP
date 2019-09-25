/* GUI for visualising the output of the NXP tilt compensated compass */
/* Ad Spiers - Sept 2019 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int Heading;      // Heading received from the serial port
int Heading_Offset = 0;   // Offset of Heading value

void setup() 
{
  size(300, 300);
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM6", 115200);  // change to your port
}

void draw()
{
  // Read available serial data
  if ( myPort.available() > 0) {  // If data is available,
    String Incoming = (myPort.readStringUntil(10)); // 59 = ; in ASCII
    
   if (Incoming != null) {
      try {
        Heading = Integer.parseInt(Incoming.trim());
        
        println(Heading);
        
      } catch (NumberFormatException npe){
       // Not an integer so forget it
      }
    }
  }
  
  
  int R = 60;  // radius of the circle
  
  int Heading2 = Heading - Heading_Offset;
  
  // calculate compass position for drawing
  float Heading_indicator_Y = -R*cos(radians(Heading2));
  float Heading_indicator_X = R*sin(radians(Heading2));
  
  // draw the compass
  background(255);             
  noFill();
  ellipse((width/2), (height/2),R*2,R*2);
  stroke(10);
  fill(200,20,50);
  ellipse((width/2) + Heading_indicator_X, (height/2) + Heading_indicator_Y,20,20); 
  
}

// pressing 'c' centers the output 
void keyPressed() {
  if (key == 'c'){
  Heading_Offset = Heading;
  }
}
