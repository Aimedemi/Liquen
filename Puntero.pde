 class Puntero{
    
    PImage img;
    int x;
    int y;
      boolean isGolpe = false;
      int n = round(random(1,10));
    
  Fisica fisica;
  
    public PVector loc, fuerza;
    
    public int mass;
    
    
    Puntero(PImage img){
      
     loc = new PVector(img.width/2, img.height/2);
        fisica = new Fisica(loc);
        fuerza = new PVector(0.5, 0.5);
        mass= floor(random(1,10));
    }
    
    void finalCheck(){
      fisica.checkEdges();
    }
    
  }
