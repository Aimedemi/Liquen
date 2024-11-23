class PixelVibrator{
  
    void processPixelVibration(float amp) {
      
      loadPixels();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int locPixel = x + y*width;
        int newX = randomInt(x-floor(amp*20), x+floor(amp*20));
        //Aca esta lo de la vibracion -->
        int newY = randomInt(y-floor(amp*30), y+floor(amp*30));
        int newPixelLoc = x + newY*width;
        pixels[locPixel] = pixels[newPixelLoc];
      }
    }
    
updatePixels();
  }
  
    int randomInt(int low, int high) {
    int r = floor(random(low, high+1));
    r = constrain(r, low, high);
    return r;
  }
}
