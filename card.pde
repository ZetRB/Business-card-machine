class Card{
  String name = "ZET ROPER-BLACKMAN";
  String website = "zetroperblackman.com";
  PImage background;
  color text, highlight;
  int x;
  int y;
  Card(String imageName, color bright,color sat){
    text = bright;
    highlight = sat;
    background = loadImage(imageName);
    setup();
  }
  
  void setup(){
   background.resize(int(width*(random(1,1.5))),0);
   x = int(random(width-background.width/2,0+background.width/2));
   y = int(random(height-background.height/2,0+background.height/2));
   println(x , ":", y);
  }
  
  void draw(){
     imageMode(CENTER);
   image(background,x,y); 
  }
}
