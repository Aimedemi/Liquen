class Puntero {

  PImage img;
  int x;
  int y;
  boolean isGolpe = false;
  int n = round(random(1, 10));

  Fisica fisica;

  public PVector loc, fuerza;

  public int mass;


  Puntero(PImage img) {

    loc = new PVector(width/2, height/2);
    fisica = new Fisica(loc);
    fuerza = new PVector(0.5, 0.5);
    mass= floor(random(1, 10));
  }

  void golpe() {
    float randX, randY;
    fisica.golpe();
    randX = fuerza.x * random(-1.5, 0.5);
    randY = fuerza.y * random(-1.5, 0.5);
    fuerza.x = randX>-0.1 && randX<0.1?randX*2.5:randX;
    fuerza.y *= randY>-0.1 && randY<0.1?randY*2.5:randY;
  }

  void finalCheck() {
    fisica.checkEdges();
  }
}
