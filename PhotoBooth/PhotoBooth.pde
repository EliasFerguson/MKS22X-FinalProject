import processing.video.*;

Capture cam;
PImage curr, prev;
int threshold = 25;

void setup() {
  size(640, 480);
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
    cam.start();
  }
}

void draw() {
  thresholdChange();
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
  }
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

void reversePosterize() {
  pushMatrix();
  scale(-1, 1);
  float num = random(2.0,15.0);
  curr.filter(POSTERIZE, num);
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
  curr = thermal1(curr);
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
