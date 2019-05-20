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

  background = loadImage("background.jpeg");
  background.resize(640, 480);
}

void draw() {
  thresholdChange();
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  if (key == '1') {
    // EDGE DETECT
    image(edgeDetect(cam, threshold), 0, 0);
  }
  if (key == '2') {
    // CARTOON EFFECT
    image(cartoonEffect(cam, threshold), 0, 0);
  }
  if (key == '3') {
    // COLORED EDGES
    image(colorEdge(cam, threshold-10), 0, 0);
  }
  if (key == '4' && clicksDone) {
    // BLUE SCREEN
    image(blueScreen(cam, background, threshold, max, mid, low), 0, 0);
  }
  if (key == '5') {
    // THERMAL
    image(thermalScreen(cam, threshold-10), 0, 0);
  }
   if (key == '6') {
    // THERMAL2
    image(thermal1(cam), 0, 0);
  }
  
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

PImage edgeDetect(PImage Image, int threshold) {
  Image = grayscale(Image);
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

PImage cartoonEffect(PImage Image, int threshold) {
  Image = grayscale(Image);
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

PImage colorEdge(PImage Image, int threshold) {
  PImage grayImage = grayscale(Image);
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

PImage blueScreen(PImage Image, PImage background, int threshold, color max, color mid, color low) {
  PImage bScreenImg = new PImage(Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      for (int i=0; i<3; i++) {
        float distMax = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(max), green(max), blue(max)); 
        float distMid = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(mid), green(mid), blue(mid));
        float distLow = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(low), green(low), blue(low));
        if ((distMax < threshold) || (distMid < threshold) || (distLow < threshold)) {
          bScreenImg.set(x, y, background.get(x, y));
        } else {
          bScreenImg.set(x, y, Image.get(x, y));
        }
      }
    }
  }
  return(bScreenImg);
}

PImage thermalScreen (PImage Image, int threshold) {
  PImage grayImage = grayscale(Image);
  threshold = 85;
    PImage tScreen = new PImage(grayImage.width, grayImage.height);
  for (int y=0; y<grayImage.height; y++) {
    for (int x=0; x<grayImage.width; x++) {
      if (brightness(Image.get(x, y)) >= (255-62)) {
        tScreen.set(x, y, color(255, 0, 0));
      }
      if ((brightness(Image.get(x, y)) >= ((255-84)) && (brightness(Image.get(x, y)) < (255-62)))) {
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
      }
      if ((brightness(Image.get(x, y)) < (255-224))) {
        tScreen.set(x, y, color(238, 130, 238));
      }
      
      
     
    }
  }
  return (tScreen);
}

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
    }
  }
  return(thermImage);
}


int clicks=0;
color max, mid, low;
boolean clicksDone = false;
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
