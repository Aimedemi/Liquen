int coreDiameter = 5;
  int dHeight;
import processing.sound.*;
Amplitude amp;
AudioIn in;

Huesped[] huespedes = new Huesped[20];

void settings() {
  fullScreen();
  //size(displayWidth/2, displayHeight/2);
  dHeight=displayHeight;
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 1);
  in.start();
  amp.input(in);
  
}

void setup(){
  
      for(int i = 0; i<20;i++){
    huespedes[i] = new Huesped(int(random(displayWidth)), int(random(displayHeight)));
  }
}


void draw() {
  frameRate(60);

  background(#081117);

  LichenCorePlug plug = new LichenCorePlug(coreDiameter, dHeight, amp.analyze());

  noStroke();
  fill(#a8f52c);
  circle(width/2, height/2, coreDiameter);

  plug.execute();
  
  //  for(int i = 0; i<20;i++){
  //huespedes[i].execute();
  //  }
}

float waveNumber(int num){
  return map(cos((frameCount*0.5) % frameRate),-1,1,num-2,num+2);
}
