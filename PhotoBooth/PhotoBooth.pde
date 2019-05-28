import processing.video.*;
import controlP5.*;
Capture cam;
PImage curr, prev;
PImage preview1, preview2, preview3, preview4, preview5, preview6, preview7, preview8;
ArrayList<PImage> previews;
int threshold = 25;
ControlP5 control;
int picNum;

void setup() {
  picNum = 1;
  control = new ControlP5(this);
  control.addBang("takePic")
    .setSize(60, 40)
    .setPosition(290, 560)
    .setLabel("Take Picture")
    .setValue(0)
    ; 
  control.addSlider("R")
    .setRange(0, 255)
    .setSize(250, 10)
    .setPosition(400, 630)
    .setLabel("Red")
    ;
  control.addSlider("G")
    .setRange(0, 255)
    .setSize(250, 10)
    .setPosition(400, 610)
    .setLabel("Green")
    ;
  control.addSlider("B")
    .setRange(0, 255)
    .setSize(250, 10)
    .setPosition(400, 590)
    .setLabel("Blue")
    ;
  size(640, 640);
  fill(204, 102, 0);
  rect(0, 480, 640, 60);
  fill(255);
  preview1 = new PImage(80, 60);
  preview2 = new PImage(80, 60);
  preview3 = new PImage(80, 60);
  preview4 = new PImage(80, 60);
  preview5 = new PImage(80, 60);
  preview6 = new PImage(80, 60);
  preview7 = new PImage(80, 60);
  preview8 = new PImage(80, 60);
  previews = new ArrayList<PImage>();
  previews.add(preview1);
  previews.add(preview2);
  previews.add(preview3);
  previews.add(preview4);
  previews.add(preview5);
  previews.add(preview6);
  previews.add(preview7);
  previews.add(preview8);
  preview1 = curr;
  preview2 = curr;
  preview3 = curr;
  preview4 = curr;
  preview5 = curr;
  preview6 = curr;
  preview7 = curr;
  preview8 = curr;
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
    curr = cam.copy();
  }
  reverseImage();
  displayPreviews();
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

 void displayPreviews() {
   int x = 40;
   for (int i = 0; i < 8; i++) {
     image(curr.copy(), x, 510, 80, 60);
     x += 80;
   }
 }
 
 
  
  
 
