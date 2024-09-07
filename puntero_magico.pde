
class PunteroMagicoDecorator {

  PImage img;
  int x;
  int y;
  boolean isGolpe = false;
  int n = round(random(1, 10));

  Puntero[] punteros;


  PunteroMagicoDecorator(PImage img) {

    this.img = img;

    punteros = new Puntero[n];

    for (int i=0; i<n; i++) {
      punteros[i]= new Puntero(img);
    }
  }

  void decorar(int[] params, float amp, int x, int y) {

    int locPixel = x + y*width;

    // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
    float r = red(img.pixels[locPixel]);
    float g = green(img.pixels[locPixel]);
    float b = blue(img.pixels[locPixel]);

    //decorator puntero magico
    if (b<params[2] && r<params[0] && g<params[1] && brightness(color(r, g, b))<200) {
      //Aca esta la vibracion de color
      b *= amp * 150;

      float distance= dist(x, y, punteros[0].loc.x*punteros[0].mass, punteros[0].loc.y*punteros[0].mass);
      for (int i=1; i<n; i++) {
        distance = distance < dist(x, y, punteros[i].loc.x*punteros[i].mass, punteros[i].loc.y*punteros[i].mass)? distance : dist(x, y, punteros[i].loc.x*punteros[i].mass, punteros[i].loc.y*punteros[i].mass);
      }

      float diameter = isGolpe?100:50;

      float adjustBrightness = diameter/distance;
      if (adjustBrightness>=1) {
        b *= adjustBrightness;
        g *= adjustBrightness;
        r *= adjustBrightness;
      } else {
        r = constrain(r, 0, params[0]);
        g = constrain(g, 0, params[1]);
        b = constrain(b, 0, params[2]);
      }
    }

    //Setea pixel procesado
    pixels[locPixel] = color(r, g, b);
  }

  public void updatePunteros(float amp) {
    applyBeat();
    for (int i=0; i<n; i++) {
      punteros[i].fisica.applyForce(punteros[i].fuerza, punteros[i].mass);
      punteros[i].fisica.update(amp);
    }
  }

  public void applyBeat() {
    if (beat.isBeat()) {
      for (int i=0; i<n; i++) {
        float randX, randY;
        punteros[i].golpe();
      }
      isGolpe=true;
    }
  }

  public void finallyPunteros() {
    for (Puntero p : punteros) {
      p.finalCheck();
    }
    isGolpe = false;
  }

  void keyPressed() {
    if (key == 'n') {
      punteros = (Puntero[]) append(punteros, new Puntero(img));
      n++;
    }
    for (Puntero p : punteros) {
      switch(keyCode) {
      case UP:
        p.fuerza.y -= 0.1;
        break;
      case DOWN:
        p.fuerza.y += 0.1;
        break;
      case RIGHT:
        p.fuerza.x += 0.1;
        break;
      case LEFT:
        p.fuerza.x -= 0.1;
        break;
      default:
        break;
      }
      p.fuerza.normalize();
    }
  }
}
