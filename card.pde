class Card{
  Grid grid;
  PVector location, opposite;
  String forename = "ZET";
  String surname = "ROPER-BLACKMAN";
  String website = "This business card was designed by a robot- find out how at zetroperblackman.com";
  PImage background;
  color text, highlight;
  int surnameSize = int(random(50,120));
 
  int forenameSize = int(random(surnameSize+50,surnameSize+150));
  int yOffset;
  int offsetVal = forenameSize;//100;
  int x;
  int y;
  int sideBias = 0; // a way of making text follow or avoid edges.
  Card(String imageName, color bright,color sat){
    text = establishColourScheme(imageName)[0];
    highlight = establishColourScheme(imageName)[1];
    //text = bright;
    //highlight = sat;
   // text = brightest;
   // highlight = saturated;
    background = loadImage(imageName);
    setup();
    
  }
  
  void setup(){
   background.resize(int(width*(random(1,1.5))),0);
   x = int(random(width-background.width/2,0+background.width/2));
   y = int(random(height-background.height/2,0+background.height/2));
   println(x , ":", y);
   println("forename size" , forenameSize);
   println("surname size" , surnameSize);
   grid = new Grid(width/60,2,2);
   location = grid.findGrid(sideBias);
   opposite = grid.findGrid(chooseEdge(sideBias*-1));
   println(location);
   
  }
  
  int chooseEdge(int bias){
   if(bias != 0){
    return bias; 
   } else {
    int edge = int(random(-2.5,2.5));
    return edge;
   }
  }
  
  void setTextAlign(int z){
    if(z == 1){
     textAlign(LEFT,TOP);
     yOffset = offsetVal;
    } if(z == 3){
     textAlign(RIGHT,TOP);
     yOffset = offsetVal;
    } if(z == 7){
     textAlign(LEFT,BOTTOM);
     yOffset = -1*offsetVal;
    } if(z == 9){
     textAlign(RIGHT,BOTTOM); 
     yOffset = -1*offsetVal;
    }
  }
  
  void draw(){
    setTextAlign(int(location.z));
     imageMode(CENTER);
   image(background,x,y);
  grid.draw();
  fill(255,0,0);
  ellipse(location.x,location.y, 20,20);
  fill(brightest);
  textFont(universConB,forenameSize);
  text(forename,location.x,location.y);
  textFont(universConB,surnameSize);
  text(surname,location.x,location.y + yOffset);
  }
}
