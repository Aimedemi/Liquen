int tileSize = 4;
float scl = 0.03;
float time = 0;  // Variable para el tiempo y la animación

float transition = 0;  // Variable de transición entre paletas

float[][] offsetsX; // Almacena los desplazamientos en X de cada tile
float[][] offsetsY;

color color1 = color(38, 70, 83);    // #264653 - Verde oscuro
color color2 = color(40, 114, 113);  // #287271 - Verde azulado
color color3 = color(42, 157, 143);  // #2a9d8f - Verde claro
color color4 = color(138, 177, 125); // #8ab17d - Verde oliva claro
color color5 = color(233, 196, 106); // #e9c46a - Amarillo mostaza
color color6 = color(239, 179, 102); // #efb366 - Amarillo cálido
color color7 = color(244, 162, 97);  // #f4a261 - Naranja suave
color color8 = color(231, 111, 81); 

// Segunda paleta (que será la que transiciona hacia ella)
color color1B = color(0, 43, 0);      // #002b00 - Verde muy oscuro
color color2B = color(77, 116, 54);   // #4d7436 - Verde musgo
color color3B = color(0, 135, 62);    // #00873e - Verde brillante
color color4B = color(192, 167, 114); // #c0a772 - Amarillo suculenta
color color5B = color(227, 218, 193); // #e3dac1 - Beige claro
color color6B = color(228, 0, 16);    // #e40010 - Rojo brillante
color color7B = color(128, 21, 10);   // #80150a - Rojo oscuro
color color8B = color(84, 3, 14);     // #54030e - Marrón oscuro

void setup() {
  noStroke();
  colorMode(HSB);
  frameRate(60);
  offsetsX = new float[width / tileSize][height / tileSize]; // Inicializa los offsets
  offsetsY = new float[width / tileSize][height / tileSize];
}

void settings() {
  //size(displayWidth / 2, displayHeight / 2);
  fullScreen();
}

void draw() {
  transition = (sin(radians(time)) + 1) / 6;  
  drawLiquen();
  time += 1;  // Aumenta el tiempo para la animación
}

void drawLiquen() {
  for (int i = 0; i < width / tileSize; i++) {
    for (int j = 0; j < height / tileSize; j++) {
      // Calcula el desplazamiento y deformación de cada tile
      offsetsX[i][j] += radians(time + i ) * random(-0.001, 0.0005); // Movimiento horizontal
      offsetsY[i][j] += radians(time + j ) * random(-0.0005, 0.001); // Movimiento vertical

      pushMatrix();
      fill(getColour(int(i + offsetsX[i][j]), int(j + offsetsY[i][j]),transition));
      rect(i * tileSize, j * tileSize, tileSize, tileSize);
      popMatrix();
    }
  }
}

color getColour(int x, int y, float t) {
  // Usamos el valor de ruido para decidir el color basado en probabilidades ajustadas
  float v = noise(x * scl, y * scl);

  // Interpolación de colores entre la paleta 1 y la paleta 2 basada en t
  color col1, col2;
  
  if (v < 0.3) {
    col1 = color1; col2 = color1B;
  }
  else if (v < 0.45) {
    col1 = color2; col2 = color2B;
  }
  else if (v < 0.6) {
    col1 = color3; col2 = color3B;
  }
  else if (v < 0.7) {
    col1 = color4; col2 = color4B;
  }
  else if (v < 0.8) {
    col1 = color5; col2 = color5B;
  }
  else if (v < 0.9) {
    col1 = color6; col2 = color6B;
  }
  else if (v < 0.98) {
    col1 = color7; col2 = color7B;
  }
  else {
    col1 = color8; col2 = color8B;
  }

  // Retorna el color interpolado entre las dos paletas según t
  return lerpColor(col1, col2, t);
}

int valueVibration(int value) {
  return int(random(value - 10, value + 10));
}
