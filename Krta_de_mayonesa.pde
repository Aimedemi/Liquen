import controlP5.*; //<>// //<>//
import processing.video.*;
import processing.sound.*;
//import com.hamoid.*;

//VideoExport videoExport;
ControlP5 sliders;
Dibujo dibujo;
Movie video;
int canvas = 574;
int sliderRed= 110;
int sliderGreen= 130;
int sliderBlue= 100;
boolean isReady=false;
boolean audioReady=false;
boolean sliderOn=false;
SoundFile sample;
Amplitude rms;
BeatDetector beat;
FFT fft;
PinkNoise noise;
int ERROR_MESSAGE=1;

void setup() {
  size(574, 574);
  // videoExport = new VideoExport(this, "myVideo.mp4");
  // videoExport.setFrameRate(30);
  //videoExport.startMovie();
  //Sound s = new Sound(this);
  //s.inputDevice(17);




  //Seleccion de imagen
  selectImage();

  selectAudio();


  sliders = new ControlP5(this);

  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue'
  sliders.addSlider("sliderBlue")
    .setPosition(20, 50)
    .setRange(0, 255)
    .setCaptionLabel("azul")
    ;
  sliders.addSlider("sliderGreen")
    .setPosition(20, 100)
    .setRange(0, 255)
    .setCaptionLabel("verde")
    ;
  sliders.addSlider("sliderRed")
    .setPosition(20, 150)
    .setRange(0, 255)
    .setCaptionLabel("rojo")
    ;
}

void draw() {
  //Espera a que se ejecute fileSelected()
  try {
    if (isReady && audioReady) {
      int[] params= {sliderRed, sliderGreen, sliderBlue};

      dibujo.draw(params, rms.analyze(), beat);
    } else if (frameCount > 6000) {
      throw new Exception();
    }
  }
  catch (Exception e) {
    e.printStackTrace();
    exit();
  }
  // videoExport.saveFrame();
}

void selectAudio() {
  //selectInput("Elegi audio:", "audioSelected");
  initAudioIn();
}

void initAudioIn() {
  Sound s = new Sound(this);
  s.inputDevice(1);
  AudioIn in = new AudioIn(this, 0);
  rms = new Amplitude(this);
  rms.input(in);
  beat = new BeatDetector(this);
  beat.input(in);
  beat.sensitivity(2);
  audioReady = true;
}


void audioSelected(File selection) {
  try {
    sample = new SoundFile(this, selection.getAbsolutePath());
    sample.loop();
    rms = new Amplitude(this);
    rms.input(sample);
    beat = new BeatDetector(this);
    beat.input(sample);
    beat.sensitivity(2);
    audioReady = true;
  }
  catch (Exception e) {
    e.printStackTrace();
    exit();
  }
}

void selectImage() {
  selectInput("Elegi imagen:", "fileSelected");
}

void fileSelected(File selection) {
  try {
    //Crea objeto dibujo
    //video = new Movie(this,selection.getAbsolutePath());
    //video.loop();
    dibujo = new Dibujo(selection.getAbsolutePath(), canvas);
    isReady = true;
  }
  catch (Exception e) {
    e.printStackTrace();
    exit();
  }
}


void movieEvent(Movie video) {
  dibujo = new Dibujo(video, canvas);
}

void keyPressed() {

  switch(key) {
  case CODED:
    dibujo.keyPressed();
    break;
  case 'n':
    dibujo.keyPressed();
    break;
  case 'x':
  isReady = false;
    selectImage();
    break;
  case 'q':
    //videoExport.endMovie();
    exit();
    break;
  default:
    if (sliderOn) {
      sliderOn=false;
      sliders.hide();
    } else {
      sliderOn=true;
      sliders.show();
    }
  }
}
