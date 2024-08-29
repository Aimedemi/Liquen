class Fisica {

  public PVector vel, acc;
  public PVector loc;
  float margen = 50; 
  float contrafuerzaX;
  float contrafuerzaY;
  
  Fisica(PVector _loc){
 
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    loc = _loc;
  }
  
    void applyForce(PVector force, int mass) {
    PVector f = PVector.div(force,mass);
    acc.add(f);
  }
  
  void update(float amp) {
    vel.add(acc);
    amp = (amp>0?amp * 20:1);
    println("loc1:"+loc);
    loc.add(new PVector(sin(vel.x*amp*contrafuerzaX), sin(vel.y*amp*contrafuerzaY)));
    println("loc2:"+loc);
    acc.mult(0);
  }
  
   void checkEdges() {
     float distance;

    if (vel.y > 0) {
       distance = dist(loc.x,loc.y,loc.x,height);
    }
      else{
         distance = dist(loc.x,loc.y,loc.x,0);
      }
      println("disty:"+ margen/distance);
      if(margen/distance >= 0.9){
        vel.y *=  -1;
      }
      contrafuerzaY = 1 - margen/distance;
       acc.x *= 1 + margen/distance * 10;
      
 if (vel.x > 0) {
       distance = dist(loc.x,loc.y,width,loc.y);
    }
      else{
         distance = dist(loc.x,loc.y,0,loc.y);
      }
      println("distx:"+ margen/distance);
      if(margen/distance >= 0.9){
        vel.x *=  -1;
      }
     contrafuerzaX = 1 - margen/distance;
     acc.y *= 1 + margen/distance * 10;
    }


  
  void golpe(){
    vel.y *= random(-5,-0.5);
    vel.x *= random(-5,-0.5);
    vel.normalize();
    vel.y = vel.y>-0.1 && vel.y<0.1?vel.y*20:vel.y;
    vel.x = vel.x>-0.1 && vel.x<0.1?vel.x*20:vel.x;
    println("vel="+vel);
  }
  
  
}
