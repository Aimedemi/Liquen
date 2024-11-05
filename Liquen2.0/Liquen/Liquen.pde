int coreDiameter = 80;
  int dHeight;

void settings() {
  fullScreen();
  //size(displayWidth/2, displayHeight/2);
  dHeight=displayHeight;
}


void draw() {
  frameRate(60);

  background(#0F0F0F);
  
  

  LichenCorePlug plug = new LichenCorePlug(coreDiameter, dHeight);

  noStroke();
  fill(255);
  circle(width/2, height/2, coreDiameter);


  plug.execute();
}
