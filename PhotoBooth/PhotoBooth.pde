import controlP5.*;
import processing.video.*;
Capture live;
boolean onScreen;
PImage curr, prev;
void setup() {
  size(640, 480);
  onScreen = true;
  imageMode(CENTER);
  live = new Capture(this);
  //curr = new PImage(700, 400);
  live.start();
}
void draw() {
  if (live.available()) {
   live.read();
  }
  image(live, 0, 0);
}
void displayImage() {
  
}
