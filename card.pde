class Card {
  Grid grid;
  int cWidth = 1000;
  int cHeight = 618;
  PVector location, opposite;
  String forename = "ZET";
  String surname = "ROPER-BLACKMAN";
  String website = "This business card was designed by a robot- find out how at zetroperblackman.com";
  String flyerBlurb = "A robot designed this flyer while I was :";
  StringList adjectives;
  StringList lines = new StringList();
  PImage background;
  color text, highlight;
  boolean flyer;
  int flyerPassageWidth = 400;
  int textSpacing = 1;
  int surnameSize;
  int forenameSize;
  int yOffset;
  int offsetVal;//100;
  int x;
  int y;
  int sideBias = 0; // a way of making text follow or avoid edges.

  Card(String imageName, boolean flyer, StringList doingWords) {

    text = establishColourScheme(imageName)[0];
    highlight = establishColourScheme(imageName)[1];

    this.flyer = flyer;
    this.adjectives = doingWords;
    println("constructor doing words");
    //printArray(adjectives);
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
      orderAdjectives();
      print("lines Array - ");
      printArray(lines);
    }
    surnameSize = int(random(minSize, maxSize));
    forenameSize = int(random(surnameSize+minSize, surnameSize+maxSize));
    offsetVal = forenameSize;
  }

  void resize(boolean flyer) {
    float lowerSF = 1;
    float upperSF = 1.5;
    cWidth = 1000;
    cHeight = 618;
    if (flyer) {
      lowerSF = 1.5;
      upperSF = 2;
      cWidth = 618;
      cHeight = 1000;
    }
    surface.setSize(cWidth, cHeight);
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

  void orderAdjectives() {
    while (adjectives.size() >= 1) { // pick first word and remove it from list
      int random = int(random(0, adjectives.size()));
      String temp = adjectives.get(random);
      adjectives.remove(random);

      if (adjectives.size() == 0) {  // check to see if there are no wirds left
        lines.append(temp);
        return;
      } 

      random = int(random(0, adjectives.size())); // pick second word
      String temp2 = adjectives.get(random);
      adjectives.remove(random);
      String temp3 = temp + " - " + temp2;
      //println("temp3- " + temp3);
      lines.append(temp3);
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
      textSpacing = -1;
    } 
    if (z == 9) {
      textAlign(RIGHT, BOTTOM); 
      yOffset = -1*offsetVal;
      textSpacing = -1;
    }
  }

  void draw() {
    surface.setSize(cWidth, cHeight);
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
    if (flyer) {
      drawLines();
    }
  }

  void drawLines() {
    int totalOffset = 0;
    for (String line : lines) {
      float size =getSize(line);
      textFont(universConB, size);
      text(line, location.x, location.y + yOffset +totalOffset);
      if (textSpacing > 0) {
        totalOffset += size;
      } else {
        totalOffset -= size;
      }
    }
  }


  float getSize(String subject) {
    int tempSize = 10;
    int loopCount = 0;
    textFont(universConB, tempSize);
    while (( flyerPassageWidth - textWidth(subject)) < 20) {
      loopCount ++;
      if ( textWidth(subject) > flyerPassageWidth){
       tempSize -= 0.5; 
      } else {
       tempSize += 0.5; 
      }
    }
    println("loops" + loopCount);
    return tempSize;
  }
}
