class LichenCorePlug {
  
  void execute(){
    float diameter = 100;
  for(int x=0 ; x<width ; x++){
    for(int y=0 ; y<height ; y++){
      float distance = dist(x,y,width/2,height/2);
      
      if(distance<diameter && distance>39){
         float blur = 255-map(distance,39,diameter,0,255);
         int vibratedBlur = int(random(blur-10,blur+10));
         //int vibratedBlur = int(blur);
          stroke(255, vibratedBlur);
          point(x,y);
      }
    }
  }
  }
}
