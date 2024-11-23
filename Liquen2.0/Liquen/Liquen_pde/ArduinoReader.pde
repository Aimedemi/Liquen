import processing.serial.*;

class ArduinoReader {
  Serial myPort;

  ArduinoReader(Serial port) {
    myPort = port;
  }
  
  void serialEvent(Serial myPort) {
  receivedData = myPort.readStringUntil('\n'); // Leer datos hasta '\n'
  
  if (receivedData != null) {
    receivedData = trim(receivedData); // Eliminar espacios en blanco
    String[] values = split(receivedData, ','); // Dividir por la coma

    if (values.length == 2) { // Asegurarse de que haya dos valores
      var1 = int(values[0]);
      var2 = map(float(values[1]),0,290,0.005,1);
    }
  }
}
}
