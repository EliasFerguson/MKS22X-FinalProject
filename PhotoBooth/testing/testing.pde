import processing.video.*;
import controlP5.*;
<<<<<<< HEAD
import java.awt.*;
import gab.opencv.*;
Capture cam, camP;
PImage curr, prev, bech, pCurr, pPrev, toBeSaved;
PImage preview1, preview2, preview3, preview4, preview5, preview6, preview7, preview8;
ArrayList<PImage> previews;
OpenCV opencv;
int threshold;
ControlP5 control, previewControl, globalControl;
=======

// Import the library
import gab.opencv.*;

import java.awt.Rectangle;

Capture cam;

// Library object
OpenCV opencv;

// Array of faces found
Rectangle[] faces;

PImage curr, prev, beach;
PImage preview1, preview2, preview3, preview4, preview5, preview6, preview7, preview8;
ArrayList<PImage> previews;
int threshold = 25;
ControlP5 control;
>>>>>>> master
int picNum;
float strands;
int clicks=0;
color max, mid, low;
boolean clicksDone = false;
<<<<<<< HEAD
boolean modes, camera, gray, edge, poster, invert, cartoon, colored, thermal;


void setup() {
  modes = false;
  bech = loadImage("bech.jpeg");
  bech.resize(640, 480);
  picNum = 1;
  strands = random(2.0, 15.0);
  control = new ControlP5(this);
  previewControl = new ControlP5(this);
  globalControl = new ControlP5(this);
=======


void setup() {
  
  beach = loadImage("beach.jpeg");
  beach.resize(640, 480);
  picNum = 1;
  strands = random(2.0,15.0);
  control = new ControlP5(this);
>>>>>>> master
  control.addBang("takePic")
    .setSize(60, 40)
    .setPosition(290, 560)
    .setLabel("Take Picture")
<<<<<<< HEAD
    ; 
  control.addBang("modes")
    .setSize(60, 20)
    .setPosition(10, 500)
    .setLabel("See Modes")
    ;
  globalControl.addSlider("threshold")
    .setRange(0, 100)
    .setSize(100, 10)
    .setPosition(490, 620)
    .setLabel("Threshold")
    .setValue(4)
    ;
  previewControl.addBang("regular")
    .setSize(80, 20)
    .setLabel("Back to Current Filter")
    .setPosition(290, 580);
  previewControl.addBang("gray")
    .setLabel("Grayscale")
    .setSize(60, 20)
    .setPosition(90, 140)
    ;
  previewControl.addBang("edge")
    .setLabel("Edge-Detect")
    .setSize(60, 20)
    .setPosition(290, 140)
    ;
  previewControl.addBang("invert")
    .setLabel("X-RAY")
    .setSize(60, 20)
    .setPosition(490, 140)
    ;
  previewControl.addBang("posterize")
    .setLabel("Posterize")
    .setSize(60, 20)
    .setPosition(90, 340)
    ;
  previewControl.addBang("normal")
    .setLabel("No Filter")
    .setSize(60, 20)
    .setPosition(290, 340)
    ;
  previewControl.addBang("colored")
    .setLabel("Colored Pencil")
    .setSize(60, 20)
    .setPosition(490, 340)
    ;
  previewControl.addBang("thermal")
    .setLabel("Thermal")
    .setSize(60, 20)
    .setPosition(90, 540)
    ;
  previewControl.addBang("cartoon")
    .setLabel("Cartoon Effect")
    .setSize(60, 20)
    .setPosition(290, 540)
    ;
  previewControl.addBang("TBD")
    .setLabel("TBD")
    .setSize(60, 20)
    .setPosition(490, 540)
    ;
  size(640, 640);
  fill(255);
  pCurr = new PImage(160, 120);
  pPrev = new PImage(160, 120);
  preview1 = new PImage(160, 120);
  preview2 = new PImage(160, 120);
  preview3 = new PImage(160, 120);
  preview4 = new PImage(160, 120);
  preview5 = new PImage(160, 120);
  preview6 = new PImage(160, 120);
  preview7 = new PImage(160, 120);
  preview8 = new PImage(160, 120);
=======
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
  fill(255);
  preview1 = new PImage(80, 60);
  preview2 = new PImage(80, 60);
  preview3 = new PImage(80, 60);
  preview4 = new PImage(80, 60);
  preview5 = new PImage(80, 60);
  preview6 = new PImage(80, 60);
  preview7 = new PImage(80, 60);
  preview8 = new PImage(80, 60);
>>>>>>> master
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
  //frameRate(5);
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
<<<<<<< HEAD
    cam = new Capture(this, 640, 480, 30);
    camP = new Capture(this, 640, 480, 30);

    opencv = new OpenCV(this, 640, 480);
    opencv.loadCascade(OpenCV.CASCADE_EYE);

    camP.start();
    cam.start();
  }
}

void draw() {

  opencv.loadImage(cam);


  if (!modes) {
    previewControl.hide();
    control.show();
    background(0);
    cam.read();
    curr = cam.copy();
    imageMode(CENTER);
    //reverseImage();
    if (cam.available()) {
      if (key == '1') {
        reverseGrayScale();
      }
      if (key == '2') {
        reverseEdgeDetect();
      }
      if (key == '3') {
        reverseInvert();
      }
      if (key == '4') {
        reversePosterize();
      }
      if (key == '5') {
        reverseCartoon();
      }
      if (key == '6') {
        reverseColored();
      }
      if (key == '7') {
        reverseThermal();
      }
      if (key == '8' && clicksDone) {
        reversebech();
      }
    }
    prev = curr;
  }
  if (modes) {
    camP.read();
    pCurr = camP.copy();
    pPrev = pCurr;
    displayPreviews();
  }
  
      noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    println(faces.length);

    for (int i = 0; i < faces.length; i++) {
      println(faces[i].x + "," + faces[i].y);
      ellipse(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
}

public void takePic() {
  cam.stop();
  toBeSaved = curr.copy();
  toBeSaved.save("PhotoBoothPhotos/" + "PhotoBooth" + picNum + ".jpg");
  cam.start();
  picNum++;
}
=======
    cam = new Capture(this, 640, 480);
    cam.start();
  }
  
    // Create the OpenCV object
  opencv = new OpenCV(this, cam.width, cam.height);
  
  // Which "cascade" are we going to use?
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  //opencv.loadCascade(OpenCV.CASCADE_EYE);  
  //opencv.loadCascade(OpenCV.CASCADE_NOSE);  
  
}

void draw() {
  thresholdChange();
  
  // We have to always "load" the camera image into OpenCV 
  opencv.loadImage(cam);
  
  // Detect the faces
  faces = opencv.detect();
  
  // Draw the video
  image(cam, 0, 0);

  // If we find faces, draw them!
  if (faces != null) {
    for (int i = 0; i < faces.length; i++) {
      strokeWeight(2);
      stroke(255,0,0);
      noFill();
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
  
  if (cam.available()) {
    cam.read();
    curr = cam.copy();
    //image(curr,0,0);
    //reverseImage();
    imageMode(CENTER);
    reverseImage();
    prev = curr;
    if (key == '1') {
     reverseGrayScale();
    }
    if (key == '2') {
     reverseEdgeDetect();
    }
    if (key == '3') {
     reverseInvert();
    }
    if (key == '4') {
     reversePosterize();
    }
    if (key == '5') {
     reverseCartoon();
    }
    if (key == '6') {
     reverseColored();
    }
    if (key == '7') {
     reverseThermal();
    }
    if (key == '8' && clicksDone) {
     reversebeach();
  }
  //curr = cam.copy();
  reverseImage();
  displayPreviews();
 }
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
>>>>>>> master

void reverseImage() {
  pushMatrix();
  scale(-1, 1);
  image(curr, -curr.width/2, curr.height/2);
  popMatrix();
}

void reverseGrayScale() {
  pushMatrix();
  scale(-1, 1);
  curr = grayScale(curr);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseEdgeDetect() {
  pushMatrix();
  scale(-1, 1);
  curr = edgeDetect(curr, threshold);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseInvert() {
  pushMatrix();
  scale(-1, 1);
  curr.filter(INVERT);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}
<<<<<<< HEAD
public void gray() {
  gray = true;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
}
public void edge() {
  gray = false;
  edge = true;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
}
public void invert() {
  gray = false;
  edge = false;
  poster = false;
  invert = true;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
}
public void posterize() {
  gray = false;
  edge = false;
  poster = true;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
}
public void regular() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = true;
  colored = false;
  thermal = false;
}
public void colored() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = true;
  thermal = false;
}
public void thermal() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = true;
}
public void cartoon() {
  gray = true;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
}
public void TBD() {
}
public void modes() {
  modes = true;
}
public void camera() {
  modes = false;
}
public void threshold(int val) {
  threshold = val;
}
=======

>>>>>>> master
void reversePosterize() {
  pushMatrix();
  scale(-1, 1);
  curr.filter(POSTERIZE, strands);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseCartoon() {
  pushMatrix();
  scale(-1, 1);
  curr = cartoonEffect(curr, threshold);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseColored() {
  pushMatrix();
  scale(-1, 1);
  curr = colorEdge(curr, threshold - 10);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseThermal() {
  pushMatrix();
  scale(-1, 1);
  curr = thermalScreen(curr);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

<<<<<<< HEAD
void reversebech() {
  pushMatrix();
  scale(-1, 1);
  curr = bech(cam, bech, threshold, max, mid, low);
=======
void reversebeach() {
  pushMatrix();
  scale(-1, 1);
  curr = beach(cam, beach, threshold, max, mid, low);
>>>>>>> master
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

PImage grayScale(PImage original) {
  PImage Image = new PImage(original.width, original.height);
  for (int y=0; y<original.height; y++) {
    for (int x=0; x<original.width; x++) {
      Image.set(x, y, color((red(original.get(x, y)) + green(original.get(x, y)) + blue(original.get(x, y)))/3));
    }
  }
  return(Image);
}


float edginess(int x, int y, PImage Image) {
  if ((x == 0) && (y == 0)) {
    return(abs(red(Image.get(x, y+1)) + red(Image.get(x+1, y))));
  }
  if ((x == Image.width) && (y == Image.height)) {
    return(abs(red(Image.get(x, y-1)) + red(Image.get(x-1, y))));
  }
  if (x == 0) {
    return(abs(red(Image.get(x, y-1)) - red(Image.get(x, y+1))) + red(Image.get(x+1, y)));
  }
  if (y == 0) {
    return(abs(red(Image.get(x-1, y)) - red(Image.get(x, y+1))) + red(Image.get(x+1, y)));
  }
  if (x == Image.width) {
    return(abs(red(Image.get(x, y-1)) - red(Image.get(x, y+1))) + red(Image.get(x-1, y)));
  }
  if (y == Image.height) {
    return(abs(red(Image.get(x-1, y)) - red(Image.get(x+1, y))) + red(Image.get(x, y-1)));
  }
  return(abs(red(Image.get(x-1, y)) - red(Image.get(x+1, y))) + abs(red(Image.get(x, y-1)) - red(Image.get(x, y+1))));
}

PImage cartoonEffect(PImage Image, int threshold) {
  Image = grayScale(Image);
  PImage cartoonImage = new PImage (Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      if (edginess(x, y, Image) > threshold) {
        cartoonImage.set(x, y, color(0));
      }
    }
  }
  return(cartoonImage);
}

PImage edgeDetect(PImage Image, int threshold) {
  Image = grayScale(Image);
  PImage edgeImage = new PImage(Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      if (edginess(x, y, Image) > threshold) {
        edgeImage.set(x, y, color(0));
      } else {
        edgeImage.set(x, y, color(255));
      }
    }
  }
  return(edgeImage);
}

PImage colorEdge(PImage Image, int threshold) {
  PImage grayImage = grayScale(Image);
  PImage colEdgeImage = new PImage(grayImage.width, grayImage.height);
  for (int y=0; y<grayImage.height; y++) {
    for (int x=0; x<grayImage.width; x++) {
      if (edginess(x, y, Image) < threshold) {
        colEdgeImage.set(x, y, color(255));
      } else {
        colEdgeImage.set(x, y, Image.get(x, y));
      }
    }
  }
  return(colEdgeImage);
}

PImage thermalScreen (PImage Image) {
  PImage grayImage = grayScale(Image);
  threshold = 85;
<<<<<<< HEAD
  PImage tScreen = new PImage(grayImage.width, grayImage.height);
=======
    PImage tScreen = new PImage(grayImage.width, grayImage.height);
>>>>>>> master
  for (int y=0; y<grayImage.height; y++) {
    for (int x=0; x<grayImage.width; x++) {
      if (brightness(Image.get(x, y)) >= (255-62)) {
        tScreen.set(x, y, color(255, 0, 0));
      }
      if ((brightness(Image.get(x, y)) >= ((255-84)) && (brightness(Image.get(x, y)) < (255-62)))) {
<<<<<<< HEAD
        tScreen.set(x, y, color(255, 165, 0));
      }
      if ((brightness(Image.get(x, y)) >= (255-112)) && (brightness(Image.get(x, y)) < (255-84))) {
        tScreen.set(x, y, color(255, 255, 0));
      }
      if ((brightness(Image.get(x, y)) >= (255-140)) && (brightness(Image.get(x, y)) < (255-112))) {
        tScreen.set(x, y, color(0, 255, 0));
      }
      if ((brightness(Image.get(x, y)) >= (255-168)) && (brightness(Image.get(x, y)) < (255-140))) {
        tScreen.set(x, y, color(135, 206, 250));
      }
      if ((brightness(Image.get(x, y)) >= (255-196)) && (brightness(Image.get(x, y)) < (255-168))) {
        tScreen.set(x, y, color(0, 0, 255));
      }
      if ((brightness(Image.get(x, y)) >= (255-224)) && (brightness(Image.get(x, y)) < (255-196))) {
        tScreen.set(x, y, color(75, 0, 130));
=======
        tScreen.set(x, y, color(255,165,0));
      }
      if ((brightness(Image.get(x, y)) >= (255-112)) && (brightness(Image.get(x, y)) < (255-84))) {
        tScreen.set(x, y, color(255,255,0));
      }
      if ((brightness(Image.get(x, y)) >= (255-140)) && (brightness(Image.get(x, y)) < (255-112))) {
        tScreen.set(x, y, color(0,255,0));
      }
      if ((brightness(Image.get(x, y)) >= (255-168)) && (brightness(Image.get(x, y)) < (255-140))) {
        tScreen.set(x, y, color(135,206,250));
      }
      if ((brightness(Image.get(x, y)) >= (255-196)) && (brightness(Image.get(x, y)) < (255-168))) {
        tScreen.set(x, y, color(0,0,255));
      }
      if ((brightness(Image.get(x, y)) >= (255-224)) && (brightness(Image.get(x, y)) < (255-196))) {
        tScreen.set(x, y, color(75,0,130));
>>>>>>> master
      }
      if ((brightness(Image.get(x, y)) < (255-224))) {
        tScreen.set(x, y, color(238, 130, 238));
      }
    }
  }
  return (tScreen);
}

<<<<<<< HEAD
PImage thermal1(PImage Image) {
  PImage thermImage = new PImage(Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      float dist = (255 - brightness(Image.get(x, y))) * 6;
      float red=0;
      float green=0;
      float blue=0;
      if (dist < 255) {
        red = dist;
      }
      if (dist >= 255) {
        red = 255;
        green = dist % 255;
      }
      if (dist >= 510) {
        red = 255 - (dist % 255);
        green = 255;
      }
      if (dist >= 765) {
        red = 0;
        blue = dist % 255;
      }
      if (dist >= 1020) {
        green = 255 - (dist % 255);
        blue = 255;
      }
      if (dist >= 1275) {
        green = 0;
        red = (dist % 255);
      }
      thermImage.set(x, y, color(red, green, blue));
=======
PImage thermal1(PImage Image){
  PImage thermImage = new PImage(Image.width,Image.height);
  for (int y=0;y<Image.height;y++){
    for (int x=0;x<Image.width;x++){
      float dist = (255 - brightness(Image.get(x,y))) * 6;
      float red=0;
      float green=0;
      float blue=0;
      if (dist < 255){
        red = dist;
      }
      if (dist >= 255){
        red = 255;
        green = dist % 255;
      }
      if (dist >= 510){
        red = 255 - (dist % 255);
        green = 255;
      }
      if (dist >= 765){
        red = 0;
        blue = dist % 255;
      }
      if (dist >= 1020){
        green = 255 - (dist % 255);
        blue = 255;
      }
      if (dist >= 1275){
        green = 0;
        red = (dist % 255);
      }
      thermImage.set(x,y,color(red,green,blue));
>>>>>>> master
    }
  }
  return(thermImage);
}

<<<<<<< HEAD
PImage bech(PImage Image, PImage replacer, int threshold, color max, color mid, color low) {
  PImage beched = new PImage(Image.width, Image.height);
=======
PImage beach(PImage Image, PImage replacer, int threshold, color max, color mid, color low) {
  PImage beached = new PImage(Image.width, Image.height);
>>>>>>> master
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      for (int i=0; i<3; i++) {
        float distMax = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(max), green(max), blue(max)); 
        float distMid = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(mid), green(mid), blue(mid));
        float distLow = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(low), green(low), blue(low));
        if ((distMax < threshold) || (distMid < threshold) || (distLow < threshold)) {
<<<<<<< HEAD
          beched.set(x, y, replacer.get(x, y));
        } else {
          beched.set(x, y, Image.get(x, y));
=======
          beached.set(x, y, replacer.get(x, y));
        } else {
          beached.set(x, y, Image.get(x, y));
>>>>>>> master
        }
      }
    }
  }
<<<<<<< HEAD
  return(beched);
}
=======
  return(beached);
}


void thresholdChange() {
  if (keyCode == UP) {
    threshold += 3;
    keyCode = LEFT;
  }
  if (keyCode == DOWN) {
    threshold -= 3;
    keyCode = RIGHT;
  }
}


>>>>>>> master
void mouseClicked() {
  if (clicks == 0) {
    max = cam.get(mouseX, mouseY);
  }
  if (clicks == 1) {
    mid = cam.get(mouseX, mouseY);
  }
  if (clicks == 2) {
    low = cam.get(mouseX, mouseY);
    clicksDone = true;
  }
  if (clicks == 3) {
    clicksDone = false;
    clicks = -1;
  }
  clicks++;
}
<<<<<<< HEAD
//

void displayPreviews() {
  control.hide();
  previewControl.show();
  imageMode(CENTER);
  background(0);
  pushMatrix();
  scale(-1, 1);
  image(grayScale(pCurr), -120, 80, 160, 120); //GRAY
  image(edgeDetect(pCurr, threshold), -320, 80, 160, 120); //EDGE
  PImage putIn = pCurr.copy();
  putIn.filter(INVERT);
  image(putIn, -520, 80, 160, 120); //XRAY
  PImage putIn2 = pCurr.copy();
  putIn2.filter(POSTERIZE, strands);
  image(putIn2, -120, 280, 160, 120); //POSTERIZE
  image(pCurr, -320, 280, 160, 120); //BASIC
  image(colorEdge(pCurr, threshold - 10), -520, 280, 160, 120); //COLOREDGE
  image(thermalScreen(pCurr), -120, 480, 160, 120); //THERMAL
  image(cartoonEffect(pCurr, threshold), -320, 480, 160, 120); //CARTOON
  popMatrix();
=======

 void displayPreviews() {
   int x = 40;
   for (int i = 0; i < 8; i++) {
     pushMatrix();
     scale(-1, 1);
     if (i == 0) image(grayScale(curr), -x, 510, 80, 60);
     if (i == 1) image(edgeDetect(curr, threshold), -x, 510, 80, 60);
     if (i == 2) {
       PImage putIn = curr.copy();
       putIn.filter(INVERT);
       image(putIn, -x, 510, 80, 60);
     }
     if (i == 3) {
       PImage putIn = curr.copy();
       putIn.filter(POSTERIZE, strands);
       image(putIn, -x, 510, 80, 60);
     }
     if (i == 4) image(cartoonEffect(curr, threshold), -x, 510, 80, 60);
     if (i == 5) image(colorEdge(curr, threshold - 10), -x, 510, 80, 60);
     if (i == 6) image(thermalScreen(curr), -x, 510, 80, 60);
     if (i == 7) image(curr, -x, 510, 80, 60);
     popMatrix();
     x += 80;
   }
}

void captureEvent(Capture cam) {
  cam.read();
>>>>>>> master
}
