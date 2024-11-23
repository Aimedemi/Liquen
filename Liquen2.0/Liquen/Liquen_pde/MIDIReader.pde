import javax.sound.midi.*;
import java.util.concurrent.ConcurrentLinkedQueue;

class MIDIReader{
  MidiDevice device;
Receiver receiver;
Transmitter transmitter;

MIDIReader(MidiReceiver receiver){
    // Obtén los dispositivos MIDI disponibles
  MidiDevice.Info[] infos = MidiSystem.getMidiDeviceInfo();
  
  // Verifica que hay dispositivos MIDI disponibles
  if (infos.length > 0) {
    // Abre el primer dispositivo MIDI
    try {
      device = MidiSystem.getMidiDevice(infos[11]);
      for(int i = 0; i < infos.length; i++){
      println(i + ":" + infos[i]);
    }
      println(device.getMaxReceivers());// Selecciona el primer dispositivo
      device.open();  // Abre el dispositivo para recibir datos

      // Configura el receptor para recibir los mensajes MIDI
      transmitter = device.getTransmitter();
      transmitter.setReceiver(receiver);
      println("Dispositivo MIDI conectado: " + infos[7].getName());
    } catch (MidiUnavailableException e) {
      println("Error al abrir el dispositivo MIDI: " + e.getMessage());
    }
  } else {
    println("No se encontraron dispositivos MIDI disponibles.");
  }
}

}

// Clase para manejar los mensajes MIDI
class MidiReceiver implements Receiver {
  
ArrayList<int[]> midiBuffer = new ArrayList<>();
final int MAX_QUEUE_SIZE = 100; // Tamaño máximo del buffer
  
  // Este método se llama cuando se recibe un mensaje MIDI
  public void send(MidiMessage message, long timeStamp) {
    byte[] midiData = message.getMessage();
    
    if (midiData[0] == (byte)0x90) { // Nota encendida (0x90 es el mensaje de 'nota on')
      int note = midiData[1];  // Número de la nota
      int velocity = midiData[2];  // Velocidad de la nota
      
      // Puedes mapear la nota MIDI a una frecuencia o a un sonido
      float frequency = midiNoteToFrequency(note);  // Convertir nota MIDI a frecuencia
      //println("Nota: " + note + " Frecuencia: " + frequency + " Velocidad: " + velocity);
      
      onMidiMessageReceived(midiData[0],midiData[1], midiData[2]);
       println(midiData);
    }
  }
  
  float midiNoteToFrequency(int note) {
  return 440.0 * pow(2, (note - 69) / 12.0); // Fórmula estándar de A4 = 440Hz
}

void onMidiMessageReceived(int note, int velocity, int channel) {
  if (midiBuffer.size() >= MAX_QUEUE_SIZE) {
    midiBuffer.remove(0); // Eliminar el mensaje más antiguo
  }
  midiBuffer.add(new int[] { note, velocity, channel });
 
}

int[] pollMIDIMessage() {
  if (!midiBuffer.isEmpty()) {
    return midiBuffer.remove(0); // Extraer el mensaje más antiguo
  }
  return null;
}

  public void close() {
  }
 
}
