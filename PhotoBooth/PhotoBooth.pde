import processing.video.*;

Capture cam;
PImage curr, prev;
int threshold = 25;


void setup() {
  size(640, 480);
  imageMode(CENTER);
  String[] cameras = Capture.list();
  curr = new PImage(640, 480);
  prev = new PImage(640, 480);
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
    prev = curr;
    curr = cam;
  }
  reverseImage();
 }
 void reverseImage() {
  pushMatrix();
  scale(-1, 1);
  image(curr, -curr.width/2, curr.height/2);
  popMatrix();
 }
  
  
 
