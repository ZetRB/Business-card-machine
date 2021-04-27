class Card {
  Grid grid;
  PVector location, opposite;
  String forename = "ZET";
  String surname = "ROPER-BLACKMAN";
  String website = "This business card was designed by a robot- find out how at zetroperblackman.com";
  PImage background;
  color text, highlight;
  boolean flyer;
  int surnameSize;
  int forenameSize;
  int yOffset;
  int offsetVal;//100;
  int x;
  int y;
  int sideBias = 0; // a way of making text follow or avoid edges.
  
  Card(String imageName, boolean flyer) {

    text = establishColourScheme(imageName)[0];
    highlight = establishColourScheme(imageName)[1];

    this.flyer = flyer;
    background = loadImage(imageName);
    setup();
  }

  void setup() {
    resize(flyer);
    textSize(flyer);

    x = int(random(width-background.width/2, 0+background.width/2));
    y = int(random(height-background.height/2, 0+background.height/2));
    println(x, ":", y);
    println("forename size", forenameSize);
    println("surname size", surnameSize);

    grid = new Grid(width/60, 2, 2);
    location = grid.findGrid(sideBias);
    opposite = grid.findGrid(chooseEdge(sideBias*-1));
    println(location);
  }

  void textSize(boolean flyer) {
    float minSize = 50;
    float maxSize = 120;
    if (flyer) {
      minSize = 30;
      maxSize = 70;
    }
    surnameSize = int(random(minSize, maxSize));
    forenameSize = int(random(surnameSize+minSize, surnameSize+maxSize));
    offsetVal = forenameSize;
  }

  void resize(boolean flyer) {
    float lowerSF = 1;
    float upperSF = 1.5;
    if (flyer) {
      lowerSF = 0.8;
      upperSF = 1.2;
    }
    background.resize(int(width*(random(lowerSF, upperSF))), 0);
  }

  int chooseEdge(int bias) {
    if (bias != 0) {
      return bias;
    } else {
      int edge = int(random(-2.5, 2.5));
      return edge;
    }
  }

  void setTextAlign(int z) {
    if (z == 1) {
      textAlign(LEFT, TOP);
      yOffset = offsetVal;
    } 
    if (z == 3) {
      textAlign(RIGHT, TOP);
      yOffset = offsetVal;
    } 
    if (z == 7) {
      textAlign(LEFT, BOTTOM);
      yOffset = -1*offsetVal;
    } 
    if (z == 9) {
      textAlign(RIGHT, BOTTOM); 
      yOffset = -1*offsetVal;
    }
  }

  void draw() {
    setTextAlign(int(location.z));
    imageMode(CENTER);
    image(background, x, y);
    grid.draw();
    fill(255, 0, 0);
    ellipse(location.x, location.y, 20, 20);
    fill(text);
    textFont(universConB, forenameSize);
    text(forename, location.x, location.y);
    textFont(universConB, surnameSize);
    text(surname, location.x, location.y + yOffset);
  }
}
