import processing.video.*;

Capture cam;
PImage background;
int threshold = 25;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No available camera(s).");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, 640, 480);
    cam.start();
  }
}

void draw() {
 
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  }
  
 
