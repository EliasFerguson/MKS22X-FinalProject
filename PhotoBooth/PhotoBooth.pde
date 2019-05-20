import controlP5.*;
import processing.video.*;
Capture live;
boolean onScreen;
PImage curr, prev;
void setup() {
  size(700, 500);
  onScreen = true;
  live = new Capture(this, 700, 400);
  curr = new PImage(700, 400);
  live.start();
}
void draw() {
  if (onScreen) {
   prev = curr;
   curr = live;
   displayImage();
  }
}
void displayImage() {
  
}
