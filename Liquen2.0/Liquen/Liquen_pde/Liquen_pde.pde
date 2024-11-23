import processing.serial.*;

int tileSize = 8;
float scl = 0.03;
float time = 0;  // Variable para el tiempo y la animación
MidiReceiver receiver = new MidiReceiver();
ArduinoReader arduinoReader;
String receivedData;       // Cadena para almacenar datos entrantes
int var1 = 0;              // Primera variable
float var2 = 0; 
Serial myPort;

Liquen liquen;

PixelVibrator vibrator;

void setup() {
  noStroke();
  frameRate(144);
  liquen = new Liquen();
  MIDIReader reader = new MIDIReader(receiver);
  vibrator = new PixelVibrator();
}

void settings() {
  size(displayWidth / 2, displayHeight / 2);
  //fullScreen();
 printArray(Serial.list()); // Mostrar la lista de puertos disponibles

  // Cambiar el índice según el puerto donde esté conectado el Arduino
  myPort = new Serial(this, Serial.list()[1], 9600); 
  myPort.bufferUntil('\n');
  arduinoReader = new ArduinoReader(myPort);
  
  
}

void draw() {
  background(0);
  arduinoReader.serialEvent(myPort);
  int[] msg = receiver.pollMIDIMessage();
  if (msg!=null)
  {
    println(var2);
    liquen.conquer(msg[1], var1);
    liquen.updateVelocity(var2);
  }
  liquen.drawLiquen();
  
  //vibrator.processPixelVibration(var2);
}

void keyPressed() {
  if (key == ' ') {
  }
}

int valueVibration(int value) {
  return int(random(value - 10, value + 10));
}
