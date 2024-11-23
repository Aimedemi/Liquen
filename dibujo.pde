 //<>// //<>//

class Dibujo {

  PImage img;

  int canva;

  boolean isReady=false;

  Fisica fisica;

  PunteroMagicoDecorator decorator;

  Dibujo(String imgPath, int canvas) {
    img = loadImage(imgPath);
    img.resize(0, height);
    surface.setSize(img.width, img.height);
    decorator = new PunteroMagicoDecorator(img);
  }

  //Dibujo(Movie video, int canvas) {
  //  img = video;
  //  img.resize(0, canvas);
  //}

  void draw(int[] params, float amp, BeatDetector beat) {

    //Carga pixels, calcula el color
    uploadPixels(params, amp);

    //Procesa vibración, sensible a amp
    processPixelVibration(amp);

    decorator.finallyPunteros();
    img = get();
  }

  void uploadPixels(int[] params, float amp) {
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
  }

  void processPixelVibration(float amp) {
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int newX = randomInt(x-floor(amp*20), x+floor(amp*20));
        //Aca esta lo de la vibracion -->
        int newY = randomInt(y-floor(amp*30), y+floor(amp*30));
        set(x, y, get(x, newY));
      }
    }
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
}
