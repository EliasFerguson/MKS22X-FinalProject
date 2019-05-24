import processing.video.*;
import controlP5.*;
Capture cam;
PImage curr, prev;
int threshold = 25;
ControlP5 control;
int picNum;

void setup() {
  picNum = 1;
  control = new ControlP5(this);
  control.addBang("takePic")
    .setSize(60, 40)
    .setPosition(290, 500)
    .setLabel("Take Picture")
    .setValue(0)
    ; 
  control.addSlider("R")
    .setRange(0, 255)
    .setSize(250, 10)
    ;
  control.addSlider("G")
    .setRange(0, 255)
    .setSize(250, 10)
    ;
  control.addSlider("B")
    .setRange(0, 255)
    .setSize(250, 10)
    ;
  size(640, 580);
  fill(255);
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
 void controlEvents(ControlEvent theEvent) {
   if (theEvent.isController()) {
     println("control event from: " + theEvent.getController().getName());
    /*if (event.isFrom("takePic")) {
     takePicture(); 
    }*/
   }
 }
 public void takePic() {
   cam.stop();
   PImage toBeSaved = prev.copy();
   toBeSaved.save("PhotoBoothPhotos/" + "PhotoBooth" + picNum + ".jpg");
   cam.start();
   picNum++;
 }
 void reverseImage() {
  pushMatrix();
  scale(-1, 1);
  image(curr, -curr.width/2, curr.height/2);
  popMatrix();
 }
  
  
 
