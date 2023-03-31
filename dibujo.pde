   //<>//
  
  class Dibujo {
  
    PImage img;
  
    int canva;
  
    boolean isReady=false;
  
    Fisica fisica;
    
     PunteroMagicoDecorator decorator;
  
    Dibujo(String imgPath, int canvas) {
      img = loadImage(imgPath);
      img.resize(int(img.width>1080?img.width*0.5:img.width), int(img.width>1080?img.height*0.5:img.height));
      surface.setSize(img.width, img.height);
      decorator = new PunteroMagicoDecorator(img);
    }
  
    Dibujo(Movie video, int canvas) {
      img = video;
      img.resize(0, canvas);
    }
  
    void draw(int[] params, float amp, BeatDetector beat) {
  
      decorator.updatePunteros(amp);
      //Carga pixels de canvas
      loadPixels();
      //Recorre imagen y procesa x pixel
      for (int y = 0; y < img.height; y++) {
        for (int x = 0; x < img.width; x++) {
          procesarPixel(x, y, params, amp);
        }
      }
      updatePixels();
      for (int y = 0; y < img.height; y++) {
        for (int x = 0; x < img.width; x++) {
          int newX = randomInt(x-100,x+100);
          int newY = randomInt(y-floor(amp*20), y+floor(amp*20));
          set(x, y, get(x, newY));
        }
      }
      decorator.finallyPunteros();
      img = get();
    }
  
    int randomInt(int low, int high) {
      int r = floor(random(low, high+1));
      r = constrain(r, low, high);
      return r;
    }
  
    void procesarPixel(int x, int y, int[] sliders, float amp) {
      decorator.decorar(sliders, amp, x, y);
    }
  
    void keyPressed() {
    decorator.keyPressed();
  }
   //<>//
  }
