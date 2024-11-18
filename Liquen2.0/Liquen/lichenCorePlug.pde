class LichenCorePlug {
  float coreRadio, blurRadio, amp;
      
      LichenCorePlug(int diameter, int dHeight, float _amp){
        coreRadio = diameter/2;
        float wave = map(sin((frameCount*0.5) % frameRate),-1,1,0.95,1.05); 
        blurRadio = coreRadio + ((wave+(_amp*5)) * dHeight/6 );
      }

  void execute(){
      translate(0,0);
  for(int x=0 ; x<width ; x++){
    for(int y=0 ; y<height ; y++){
      float distance = dist(x,y,width/2,height/2);
      
      if(distance<blurRadio && distance>coreRadio-1){
         float blur = 255-map(distance,coreRadio-1,blurRadio,0,255);
         int vibratedBlur = int(random(-blur-10,blur+10));
         strokeWeight(2);
          stroke(#0c4219, vibratedBlur);
          point(x,y);
      }
    }
  }
  }
}
