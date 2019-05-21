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
  thresholdChange();
  if (cam.available()) {
    cam.read();
    prev = curr;
    curr = cam;
  }
  reverseImage();
  if (key == '1') {
    // EDGE DETECT
    image(grayscale(cam, threshold), 0, 0);
  }
}

void reverseImage() {
  pushMatrix();
  scale(-1, 1);
  image(curr, -curr.width/2, curr.height/2);
  popMatrix();
}

PImage grayscale(PImage original) {
  PImage Image = new PImage(original.width, original.height);
  for (int y=0; y<original.height; y++) {
    for (int x=0; x<original.width; x++) {
      Image.set(x, y, color((red(original.get(x, y)) + green(original.get(x, y)) + blue(original.get(x, y)))/3));
    }
  }
  return(Image);
}

void thresholdChange(){
  if (keyCode == UP){
    threshold += 5;
    keyCode = LEFT;
  }
  if (keyCode == DOWN){
    threshold -= 5;
    keyCode = RIGHT;
  }
}
