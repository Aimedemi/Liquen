class Huesped {
  float coreRadio, blurRadio, amp;
  PShape bichito; 
  int x,y;
  
  Huesped(int _x, int _y){
    x=_x;
    y=_y;
    
          bichito = createShape(); 
  bichito.beginShape();
        bichito.fill(#0c4219);
  bichito.noStroke();
bichito.vertex(0, -50);
  bichito.vertex(14, -20);
  bichito.vertex(47, -15);
  bichito.vertex(23, 7);
  bichito.vertex(29, 40);
  bichito.vertex(0, 25);
  bichito.vertex(-29, 40);
  bichito.vertex(-23, 7);
  bichito.vertex(-47, -15);
  bichito.vertex(-14, -20);
  bichito.endShape(CLOSE);
  }
  
  void execute(){ 
    pushMatrix();
      translate(x,y);


  shape(bichito);
  popMatrix();
  }
  
  int randomNum(){
    return int(noise(random(-100,100)));
  }
   //<>//
}
