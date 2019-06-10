import processing.video.*;
import controlP5.*;
import java.awt.*;
import gab.opencv.*;

Capture cam;
PImage curr, prev, store, background, pCurr, pPrev, toBeSaved;
int thresholdGlobal, Cthreshold;
ControlP5 control, previewControl, globalControl, editor;
int picNum;
float strands;
int clicks=0;
int pointillize = 22;
color max, mid, low;
PGraphics brush;
int hdiff, sdiff, bdiff, angle;
boolean clicksDone = false;
int brightness, saturation, hue, contrast; //the contrast level of the image
boolean modes, regular, gray, edge, poster, invert, cartoon, colored, thermal, paint, replacement;
int alpha, red, blue, green;
boolean painting, facial, editing, flowering, pointying;
PImage canvas, original;
OpenCV opencv;

void setup() {
  flowering = false;
  editing = false;
  painting = false;
  pointying = false;
  canvas = new PImage(640, 480);
  original = new PImage(640, 480);
  gray = false;
  replacement = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = true;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  facial = false;
  background = loadImage("background.jpeg");
  background.resize(640, 480);
  picNum = 1;
  //strands = random(2.0, 15.0);
  control = new ControlP5(this);
  previewControl = new ControlP5(this);
  globalControl = new ControlP5(this);
  editor = new ControlP5(this);
  editor.addBang("revert")
    .setSize(40, 20)
    .setLabel("RESET")
    .setPosition(550, 500)
    ;
  editor.addToggle("startPoint")
    .setSize(40, 20)
    .setLabel("Pointilize")
    .setPosition(120, 540)
    ;
  editor.addToggle("startFlower")
    .setSize(40, 20)
    .setLabel("Flower Trail")
    .setPosition(60, 540)
    ;
  editor.addToggle("startPaint")
    .setSize(40, 20)
    .setLabel("Paint")
    .setPosition(0, 540)
    ;
  editor.addBang("saveImage") 
    .setSize(60, 40)
    .setPosition(290, 500)
    .setLabel("Save Image")
    ;
  editor.addBang("escape")
    .setSize(30, 20)
    .setPosition(10, 580)
    .setLabel("Delete Image")
    ;
  editor.addColorPicker("picker")
    .setSize(60, 80)
    .setPosition(0, 480)
    .setLabel("Color Picker")
    ;

  control.addBang("takePic")
    .setSize(60, 40)
    .setPosition(290, 500)
    .setLabel("Take Picture")
    ; 

  control.addBang("modes")
    .setSize(60, 20)
    .setPosition(10, 500)
    .setLabel("See Modes")
    ;

  control.addBang("facial")
    .setSize(60, 20)
    .setPosition(10, 550)
    .setLabel("Facial Recognition")
    ;

  globalControl.addSlider("threshold")
    .setRange(0, 100)
    .setSize(100, 10)
    .setPosition(490, 620)
    .setLabel("Threshold")
    .setValue(40)
    .plugTo(thresholdGlobal)
    ;
  previewControl.addBang("gray")
    .setLabel("Grayscale")
    .setSize(60, 20)
    .setPosition(90, 120)
    ;

  previewControl.addBang("edge")
    .setLabel("Edge-Detect")
    .setSize(60, 20)
    .setPosition(290, 120)
    ;

  previewControl.addBang("invert")
    .setLabel("X-RAY")
    .setSize(60, 20)
    .setPosition(490, 120)
    ;

  previewControl.addBang("posterize")
    .setLabel("Posterize")
    .setSize(60, 20)
    .setPosition(90, 320)
    ;
  previewControl.addBang("regular")
    .setLabel("No Filter")
    .setSize(60, 20)
    .setPosition(290, 320)
    ;
  previewControl.addBang("colored")
    .setLabel("Colored Pencil")
    .setSize(60, 20)
    .setPosition(490, 320)
    ;
  previewControl.addBang("thermal")
    .setLabel("Thermal")
    .setSize(60, 20)
    .setPosition(90, 520)
    ;
  previewControl.addBang("cartoony")
    .setLabel("Cartoon Effect")
    .setSize(60, 20)
    .setPosition(290, 520)
    ;
  previewControl.addBang("setBackground")
    .setLabel("Backdrop")
    .setSize(60, 20)
    .setPosition(490, 520)
    ;
  globalControl.addBang("zero")
    .setLabel("Zero Sliders")
    .setPosition(10, 615)
    .setSize(10, 10)
    ;
  globalControl.addSlider("brightnessIn")
    .setLabel("Brightness")
    .setPosition(340, 600)
    .setRange(-255, 255)
    .setValue(brightness) 
    .plugTo(brightness)
    ;
  globalControl.addSlider("saturationIn")
    .setLabel("Saturation")
    .setPosition(340, 620)
    .setRange(-255, 255)
    .setValue(saturation) 
    .plugTo(saturation)
    ;
  globalControl.addSlider("hueIn")
    .setLabel("Hue")
    .setPosition(490, 600)
    .setRange(-255, 255)
    .setValue(hue)    
    .plugTo(hue)
    ;

  size(640, 640);
  fill(255);
  background(0);

  pCurr = new PImage(160, 120);
  pPrev = new PImage(160, 120);
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
    cam = new Capture(this, 640, 480);

    opencv = new OpenCV(this, 640, 480);
    opencv.loadCascade(OpenCV.CASCADE_EYE);

    cam.start();

    if (mousePressed) {
      //need for flowers
      /*noStroke();
       fill(0, 102);*/
      // need for pointilie
      //smooth();
    }
  }
}

void draw() {
  if (cam.available()) {
    cam.read();
    curr = cam.copy();
    update(curr);
    if (!modes) {
      background(0);
      previewControl.hide();
      editor.hide();
      control.show();
      imageMode(CENTER);

      if (regular) {
        reverseImage();
         opencv.loadImage(curr);
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
      if (replacement) {
        reversebackground();
      }
    }

    if (modes) {
      editor.hide();
      //camP.read();
      pCurr = curr.copy();
      pPrev = pCurr;
      displayPreviews();
    }

    /*if (facial) {
     facial();
     }*/
    prev = curr;
  }
  if (editing) {
    editor.show();
    control.hide();
    if (painting) {
      paint();
    }
    if (flowering) {
      flowers();
    }
    if (pointying) {
      //pointilize(get(0, 0, 640, 480));
      pointilize(curr);
    }
  }
}
public void takePic() {
  cam.stop();
  editing = true;
  original = curr;
}
public void saveImage() {
  toBeSaved = curr.copy();
  PImage saver = createImage(640, 480, RGB);
  saver = get(0, 0, 640, 480);
  saver.save(dataPath("") + "/outputImage" + picNum + ".jpg");
  picNum++;
  editing = false;
  cam.start();
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
  curr = edgeDetect(curr, thresholdGlobal);
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

void flowers() {
  noStroke();
  if (mousePressed == true && mouseY <= 470) {
    angle += 5;
    float val = cos(radians(angle)) * 12.0;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(red, green, blue, alpha);
      ellipse(mouseX + xoff, mouseY + yoff, val, val);
    }
    fill(color(red, blue, green));
    ellipse(mouseX, mouseY, 2, 2);
  }
}

public void facial() {
 
 noFill();
 stroke(0, 255, 0);
 strokeWeight(3);
 Rectangle[] eyes = opencv.detect();
 println(eyes.length);
 
 for (int i = 0; i < eyes.length; i++) {
 println(eyes[i].x + "," + eyes[i].y);
 rect(640-eyes[i].x, eyes[i].y, eyes[i].width, eyes[i].height);
 }
 
 }

/*public void strands(float val) {
  strands = val;
}*/

public void gray() {
  gray = true;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void edge() {
  gray = false;
  edge = true;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void invert() {
  gray = false;
  edge = false;
  poster = false;
  invert = true;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void posterize() {
  gray = false;
  edge = false;
  poster = true;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void regular() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = true;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void colored() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = true;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void setBackground() {
  gray = false;
  replacement = true;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
}
public void thermal() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = true;
  modes = false;
  paint = false;
  replacement = false;
}
public void cartoony() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = true;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = false;
  replacement = false;
}
public void paintpanel() {
  gray = false;
  edge = false;
  poster = false;
  invert = false;
  cartoon = false;
  regular = false;
  colored = false;
  thermal = false;
  modes = false;
  paint = true;
  replacement = false;
}
public void modes() {
  modes = true;
}
public void picker(int col) {
  alpha = int(alpha(col)); 
  red = int(red(col));
  green = int(green(col));
  blue = int(blue(col));
}
public void threshold(int val) {
  thresholdGlobal = val;
}
void reversePosterize() {
  pushMatrix();
  scale(-1, 1);
  curr.filter(POSTERIZE, thresholdGlobal/8+3);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reverseCartoon() {
  pushMatrix();
  scale(-1, 1);
  curr = cartoonEffect(curr, thresholdGlobal/4 + 5);
  image(curr, -curr.width/2, curr.height/2 );
  popMatrix();
}

void reversePaint() {
  pushMatrix();
  scale(-1, 1);
  image(canvas, -canvas.width/2, canvas.height/2 );
  popMatrix();
}


void reverseColored() {
  pushMatrix();
  scale(-1, 1);
  curr = colorEdge(curr, thresholdGlobal);
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

void reversebackground() {
  pushMatrix();
  scale(-1, 1);
  curr = background(cam, background, thresholdGlobal, max, mid, low);
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
  PImage og = grayScale(Image);
  PImage cartoonImage = new PImage (og.width, og.height);
  for (int y=0; y<og.height; y++) {
    for (int x=0; x<og.width; x++) {
      if (edginess(x, y, og) > threshold) {
        cartoonImage.set(x, y, color(0));
      } else {
        cartoonImage.set(x, y, Image.get(x, y));
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
  int Uthreshold = thresholdGlobal - 10;
  PImage grayImage = grayScale(Image);
  PImage colEdgeImage = new PImage(grayImage.width, grayImage.height);
  for (int y=0; y<grayImage.height; y++) {
    for (int x=0; x<grayImage.width; x++) {
      if (edginess(x, y, Image) < Uthreshold) {
        colEdgeImage.set(x, y, color(255));
      } else {
        colEdgeImage.set(x, y, Image.get(x, y));
      }
    }
  }
  return(colEdgeImage);
}

PImage thermalScreen (PImage Image) {
  colorMode(RGB);
  PImage grayImage = grayScale(Image);
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

PImage background(PImage Image, PImage replacer, int threshold, color max, color mid, color low) {
  PImage backgrounded = new PImage(Image.width, Image.height);
  for (int y=0; y<Image.height; y++) {
    for (int x=0; x<Image.width; x++) {
      for (int i=0; i<3; i++) {
        float distMax = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(max), green(max), blue(max)); 
        float distMid = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(mid), green(mid), blue(mid));
        float distLow = dist(red(Image.get(x, y)), green(Image.get(x, y)), blue(Image.get(x, y)), red(low), green(low), blue(low));
        if ((distMax < threshold) || (distMid < threshold) || (distLow < threshold)) {
          backgrounded.set(x, y, replacer.get(x, y));
        } else {
          backgrounded.set(x, y, Image.get(x, y));
        }
      }
    }
  }
  return(backgrounded);
}

void bdiff() {
 // bdiff = 
}

void sdiff () {
  if (saturation > 70) sdiff = 70; 
  if (saturation < -255) sdiff = -255;
}

/*
void cdiff() {
  if (contrast > 128) contrast = 128; //ateusts the parameter, values obtained through testing
  if (contrast < -128) contrast = -128;
}
*/

PImage saturate(PImage img) {
  PImage copy = img.copy(); //creates a copy of the image 
  colorMode(HSB); //hue, saturation, brightness colorMode 
  copy.loadPixels(); //loads all the pixels 
  sdiff();
  for (int i = 0; i < copy.pixels.length; i++) { //loops through all the pixels 
    color current = copy.pixels[i]; //stores original color of pixel 
    float current_h = hue(current); //original hue of pixel, doesn't change 
    float current_s = saturation(current); //original saturation of pixel, will change
    float current_b = brightness(current); //original brightness of pixel, doesn't change

    copy.pixels[i] = color(current_h, current_s + sdiff, current_b); //sets pixel to new color
  }
  copy.updatePixels(); //updates all the pixels 
  return copy; //returns copy
}

PImage changeAspects(PImage img) {
  PImage copy = img.copy();
  colorMode(HSB);
  copy.loadPixels();
  /* bdiff();
  hdiff();
  sdiff(); */
  for (int i = 0; i < copy.pixels.length; i++) {
    color current = copy.pixels[i];
    float current_h = hue(current);
    float current_s = saturation(current);
    float current_b = brightness(current); //only the brightness of the image will be modified 

    copy.pixels[i] = color(current_h + hue, current_s + saturation, current_b + brightness);
  }
  copy.updatePixels();
  return copy;
}

void update (PImage img) {

  curr = changeAspects(img);

}

void pointilize(PImage img) {

  // background(0);
  smooth();

  // Pick a random point
  int x = int(random(img.width));
  int y = int(random(img.height));
  int loc = x + y*img.width;

  // Look up the RGB color in the source image
  loadPixels();
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  noStroke();

  // Draw an ellipse at that location with that color
  fill(r, g, b, 150);
  ellipse(640 - x, y, pointillize, pointillize);
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

void paint() {
  if (mousePressed && mouseY <= 470) {
    noStroke();
    fill(red, green, blue, alpha);
    ellipse(mouseX, mouseY, 10, 10);
  }
}

void displayPreviews() {
  control.hide();
  previewControl.show();
  imageMode(CENTER);
  background(0);
  pushMatrix();
  scale(-1, 1);
  image(grayScale(pCurr), -120, 80, 160, 120); //GRAY
  image(edgeDetect(pCurr, thresholdGlobal), -320, 80, 160, 120); //EDGE
  PImage putIn = pCurr.copy();
  putIn.filter(INVERT);
  image(putIn, -520, 80, 160, 120); //XRAY
  PImage putIn2 = pCurr.copy();
  putIn2.filter(POSTERIZE, thresholdGlobal/8+3);
  image(putIn2, -120, 280, 160, 120); //POSTERIZE
  image(pCurr, -320, 280, 160, 120); //BASIC
  image(colorEdge(pCurr, thresholdGlobal), -520, 280, 160, 120); //COLOREDGE
  image(thermalScreen(pCurr), -120, 480, 160, 120); //THERMAL
  image(cartoonEffect(pCurr, thresholdGlobal/4 + 5), -320, 480, 160, 120); //CARTOON
  image(background, -520, 480, 160, 120);
  popMatrix();
}

public void brightnessIn(int bi) {
  brightness = bi;
}
public void hueIn(int hi) {
  hue = hi;
}
public void saturationIn(int si) {
  saturation = si;
}
public void contrastIn(int ci) {
  contrast = ci;
}

public void escape() {
  editing = false;
  cam.start();
}

public void startPaint(boolean in) {
  painting = in;
}

public void startFlower(boolean in) {
  flowering = in;
}
public void startPoint(boolean in) {
  pointying = in;
}
public void revert() {
  pushMatrix();
  scale(-1, 1);
  image(original, -320, 240);
  popMatrix();
}
public void zero() {
  hue = 0;
  brightness = 0;
  saturation = 0;
}
