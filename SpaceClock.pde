import java.util.Date;

long timeOffset = 0;
PFont font;
color hoursColor   = #4A8250;
color minutesColor = #5292BE;
color secondsColor = #8C3C3C;
float clockScale = 1;
int baseWidth = 320;
int baseHeight = 96;
int prevWidth;
int prevHeight;

void setup() {
  setTimeOffset(10);
  size(baseWidth, baseHeight);
  prevWidth = width;
  prevHeight = height;
  font = loadFont("DS-Digital-255.vlw");
  frame.setResizable(true);
}

void draw() {
  listenWindowResize();
  //println(getOurHours() + ":" + doubleChar(getOurMinutes()) + ":" + doubleChar(getOurSeconds()));
  //delay(430);
  background(0xA);
  
  textFont(font, 64*clockScale);
  int offset = (int)(32*clockScale);
  
  fill(0xFF);
  textAlign(CENTER, CENTER);
  text(":", width/3, height/2);
  text(":", width*2/3, height/2);
  
  fill(hoursColor);
  textAlign(RIGHT, CENTER);
  text(fixOnes(getOurHours()), width/3-offset, height/2);
  fill(minutesColor);
  textAlign(CENTER, CENTER);
  text(fixOnes(doubleChar(getOurMinutes())), width/2, height/2);
  fill(secondsColor);
  textAlign(LEFT, CENTER);
  text(fixOnes(doubleChar(getOurSeconds())), width*2/3+offset, height/2);
}

void listenWindowResize() {
  if (width != prevWidth || height != prevHeight)
    windowResized();
}

void windowResized() {
  prevWidth = width;
  prevHeight = height;
  clockScale = min((float)width/baseWidth, (float)height/baseHeight);
}

void setTimeOffset(int hours) {
  timeOffset = (long)(hours*60*60*1000);
}

void setTimeOffset(float hours) {
  timeOffset = (long)(hours*60*60*1000);
}

long getTimeOffset() {
  return timeOffset;
}

int getOurSeconds() {
  Date d = new Date();
  d.setTime(d.getTime()+getTimeOffset()); //+10 hours
  return (int)((d.getTime()/432) % 100);
}

int getOurMinutes() {
  Date d = new Date();
  d.setTime(d.getTime()+getTimeOffset()); //+10 hours
  return (int)((d.getTime()/43200) % 100);
}

int getOurHours() {
  Date d = new Date();
  d.setTime(d.getTime()+getTimeOffset()); //+10 hours
  return (int)((d.getTime()/4320000) % 20);
}

String doubleChar(int x) {
  return doubleChar(""+x);
}

String doubleChar(String s) {
  if (s.length() <= 1)
    return "0"+s;
  else
    return s;
}

String fixOnes(int x) {
  return fixOnes(""+x);
}

String fixOnes(String s) {
  return s.replace("1", " 1");
}
