class Fisica {

  public PVector vel, acc;
  public PVector loc;
  float margenX = width/200; 
  float margenY = height/200; 
  float contrafuerzaX;
  float contrafuerzaY;
  float ampSensitivity=5;

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
    amp = (amp>0?amp * ampSensitivity:1);
    loc.add(new PVector(vel.x*amp*contrafuerzaX, vel.y*amp*contrafuerzaY));
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
      println("disty:"+ margenY/distance);
      if(margenY/distance >= 0.9){
        vel.y *=  -1;
      }
      contrafuerzaY = 1 - margenY/distance;
       acc.x *= 1 + margenY/distance * 5;

 if (vel.x > 0) {
       distance = dist(loc.x,loc.y,width,loc.y);
    }
      else{
         distance = dist(loc.x,loc.y,0,loc.y);
      }
      println("distx:"+ margenX/distance);
      if(margenX/distance >= 0.9){
        vel.x *=  -1;
      }
     contrafuerzaX = 1 - margenX/distance;
     acc.y *= 1 + margenX/distance * 5;
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
