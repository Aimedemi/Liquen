void settings() {
  size(displayWidth/2,displayHeight/2);
  
}


void draw(){
  
  background(#0F0F0F);
  noStroke();
  circle(width/2,height/2,80);
  
  LichenCorePlug plug = new LichenCorePlug();
  plug.execute();
}
