import processing.video.*;
import controlP5.*;
Capture cam, camP;
PImage curr, prev, beach, pCurr, pPrev, toBeSaved;
PImage preview1, preview2, preview3, preview4, preview5, preview6, preview7, preview8;
int threshold;
ControlP5 control, previewControl, globalControl;
int picNum;
float strands;
int clicks=0;
color max, mid, low;
boolean clicksDone = false;
boolean modes, camera, gray, edge, poster, invert, cartoon, colored, thermal;
//

void setup() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = true;
  colored = false;
  thermal = false;
  modes = false;
  beach = loadImage("beach.jpeg");
  beach.resize(640, 480);
  picNum = 1;
  strands = random(2.0, 15.0);
  control = new ControlP5(this);
  previewControl = new ControlP5(this);
  globalControl = new ControlP5(this);
  control.addBang("takePic")
    .setSize(60, 40)
    .setPosition(290, 560)
    .setLabel("Take Picture")
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
  background(0);
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
    cam = new Capture(this, 640, 480, 30);
    camP = new Capture(this, 640, 480, 30);
    camP.start();
    cam.start();
  }
}

void draw() {
  if (!modes) {
    background(0);
    previewControl.hide();
    control.show();
    cam.read();
    curr = cam.copy();
    imageMode(CENTER);
    if (camera) {
      reverseImage();
    }
    if (gray) {
      reverseGrayScale();
    }
    if (edge) {
      reverseEdgeDetect();
    }
    if (invert) {
      reverseInvert();
    }
    if (poster) {
      reversePosterize();
    }
    if (cartoon) {
      reverseCartoon();
    }
    if (colored) {
      reverseColored();
    }
    if (thermal) {
      reverseThermal();
    }
    if (key == '8' && clicksDone) {
      reversebeach();
    }
    prev = curr;
  }
  if (modes) {
    camP.read();
    pCurr = camP.copy();
    pPrev = pCurr;
    displayPreviews();
  }
}

public void takePic() {
  cam.stop();
  toBeSaved = curr.copy();
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
public void gray() {
  gray = true;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  camera = false;
  colored = false;
  thermal = false;
  modes = false;
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
  modes = false;
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
  modes = false;
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
  modes = false;
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
  modes = false;
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
  modes = false;
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
  modes = false;
}
public void cartoon() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = true;
  camera = false;
  colored = false;
  thermal = false;
  modes = false;
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

void reversebeach() {
  pushMatrix();
  scale(-1, 1);
  curr = beach(cam, beach, threshold, max, mid, low);
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
  PImage tScreen = new PImage(grayImage.width, grayImage.height);
  for (int y=0; y<grayImage.height; y++) {
    for (int x=0; x<grayImage.width; x++) {
      if (brightness(Image.get(x, y)) >= (255-62)) {
        tScreen.set(x, y, color(255, 0, 0));
      }
      if ((brightness(Image.get(x, y)) >= ((255-84)) && (brightness(Image.get(x, y)) < (255-62)))) {
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
      }
      if ((brightness(Image.get(x, y)) < (255-224))) {
        tScreen.set(x, y, color(238, 130, 238));
      }
    }
  }
  return (tScreen);
}

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
    }
  }
  return(thermImage);
}

PImage beach(PImage Image, PImage replacer, int threshold, color max, color mid, color low) {
  PImage beached = new PImage(Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      for (int i=0; i<3; i++) {
        float distMax = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(max), green(max), blue(max)); 
        float distMid = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(mid), green(mid), blue(mid));
        float distLow = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(low), green(low), blue(low));
        if ((distMax < threshold) || (distMid < threshold) || (distLow < threshold)) {
          beached.set(x, y, replacer.get(x, y));
        } else {
          beached.set(x, y, Image.get(x, y));
        }
      }
    }
  }
  return(beached);
}
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
}
