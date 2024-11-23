class Liquen {

  int tileSize = 8;
  float scl = 0.03;
  float time = 0;  // Variable para el tiempo y la animación

  color color1 = color(38, 70, 83);    // #264653 - Verde oscuro
  color color2 = color(40, 114, 113);  // #287271 - Verde azulado
  color color3 = color(42, 157, 143);  // #2a9d8f - Verde claro
  color color4 = color(138, 177, 125); // #8ab17d - Verde oliva claro
  color color5 = color(233, 196, 106); // #e9c46a - Amarillo mostaza
  color color6 = color(239, 179, 102); // #efb366 - Amarillo cálido
  color color7 = color(244, 162, 97);  // #f4a261 - Naranja suave
  color color8 = color(231, 111, 81);

  float[][] savedNoise;  // Estado actual del ruido
  float[][] nextNoise;   // Nuevo estado del ruido
  float transitionProgress = 1; // Progreso de la transición (0 a 1)
  
   int[] intensityValues;    // Historial de valores MIDI
  int intensityHistorySize = 10; // Tamaño del buffer para el filtro de suavizado

  float[] colorProportions = {0.3, 0.45, 0.6, 0.7, 0.8, 0.9, 0.98, 1.0};
  
  float velocity = 1;

  Liquen() {
    savedNoise = new float[width / tileSize][height / tileSize];
    nextNoise = new float[width / tileSize][height / tileSize];
    saveNoiseState();  // Guarda el estado inicial del ruido
    intensityValues = new int[intensityHistorySize];
  }

  void saveNoiseState() {
    for (int i = 0; i < width / tileSize; i++) {
      for (int j = 0; j < height / tileSize; j++) {
        savedNoise[i][j] = noise(i * scl, j * scl); // Guarda el valor del ruido
      }
    }
  }

  void generateNextNoiseState() {
    noiseSeed((int) random(1000));  // Cambia la semilla del ruido
    for (int i = 0; i < width / tileSize; i++) {
      for (int j = 0; j < height / tileSize; j++) {
        nextNoise[i][j] = noise(i * scl, j * scl); // Genera el nuevo estado del ruido
      }
    }
  }

  void drawLiquen() {
    for (int i = 0; i < width / tileSize; i++) {
      for (int j = 0; j < height / tileSize; j++) {
        // Interpolación entre estados de ruido
        float interpolatedNoise = lerp(savedNoise[i][j], nextNoise[i][j], transitionProgress);

        // Convertimos el ruido interpolado a un color
        color c = getColourFromNoise(interpolatedNoise);
        fill(c);
        rect(i * tileSize, j * tileSize, tileSize, tileSize);
      }
    }

    updateTransition();
  }

  void updateTransition() {
    // Incrementamos el progreso de la transición
    if (transitionProgress < 1) {
      transitionProgress += velocity < 1? 0.2 * velocity : 0.01;  // Controla la velocidad de la transición
    }
    if (transitionProgress >= 1) {
      saveNoiseState();         // El estado actual se guarda
      generateNextNoiseState(); // Genera el nuevo estado
      transitionProgress = 0;   // Reinicia la transición
    }
  }

   color getColourFromNoise(float noiseValue) {
    if (noiseValue < colorProportions[0]) return color1;
    else if (noiseValue < colorProportions[1]) return color2;
    else if (noiseValue < colorProportions[2]) return color3;
    else if (noiseValue < colorProportions[3]) return color4;
    else if (noiseValue < colorProportions[4]) return color5;
    else if (noiseValue < colorProportions[5]) return color6;
    else if (noiseValue < colorProportions[6]) return color7;
    else return color8;
  }

  void conquer(int newMidiValue, int sensitivity) {
    // Añadimos el nuevo valor MIDI al historial
    addToMidiHistory(newMidiValue);

    // Calculamos la intensidad suavizada
    float smoothedIntensity = getSmoothedMidiValue();

    // Normalizamos la intensidad para ajustar las proporciones
    float normalizedIntensity = constrain(smoothedIntensity / 127.0, 0, 1);
    float normalizedSensitivity = constrain(sensitivity / 255.0, 0.01, 0.5);

    float adjustmentFactor = normalizedIntensity * normalizedSensitivity ;

    float[] baseProportions = {0.3, 0.45, 0.6, 0.7, 0.8, 0.9, 0.98, 1.0};
    float totalExpansion = adjustmentFactor * 4;
    float totalContraction = totalExpansion / 4;

    colorProportions[0] = baseProportions[0] - totalContraction;
    colorProportions[1] = baseProportions[1] - totalContraction;
    colorProportions[2] = baseProportions[2] - totalContraction;
    colorProportions[3] = baseProportions[3] - totalContraction;

    colorProportions[4] = baseProportions[4] + adjustmentFactor;
    colorProportions[5] = baseProportions[5] + adjustmentFactor;
    colorProportions[6] = baseProportions[6] + adjustmentFactor;
    colorProportions[7] = 1.0;

    for (int i = 1; i < colorProportions.length; i++) {
      colorProportions[i] = max(colorProportions[i], colorProportions[i - 1]);
    }
  }

  void addToMidiHistory(int newValue) {
    // Desplaza el historial hacia atrás e inserta el nuevo valor al final
    for (int i = 0; i < intensityHistorySize - 1; i++) {
      intensityValues[i] = intensityValues[i + 1];
    }
    intensityValues[intensityHistorySize - 1] = newValue;
  }

  float getSmoothedMidiValue() {
    // Calcula el promedio del historial
    int sum = 0;
    for (int value : intensityValues) {
      sum += value;
    }
    return sum / (float) intensityHistorySize;
  }
  
  void updateVelocity(float vel){
    velocity = vel;
  }
}
