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
  StringList details = new StringList();
  PImage background;
  color text, highlight;
  boolean flyer;
  int margin = 60;
  int flyerPassageWidth = 0;
  int textSpacing = 1;
  int surnameSize;
  int forenameSize;
  int yOffset;
  int offsetVal;//100;
  int x;
  int y;
  float tempSize = 5;
  int sideBias = 0; // a way of making text follow or avoid edges.

  Card(String imageName, boolean flyer, StringList doingWords) {

    text = establishColourScheme(imageName)[0];
    highlight = establishColourScheme(imageName)[1];

    this.flyer = flyer;
    this.adjectives = doingWords;
    background = loadImage(imageName);
    println("Making new card from image:" + imageName + "\n");
    setup();
  }

  void setup() {
    resize(flyer);
    setTextSize(flyer);
    populateStringList();
    x = int(random(width-background.width/2, 0+background.width/2));
    y = int(random(height-background.height/2, 0+background.height/2));

    grid = new Grid(margin, 2, 2);
    location = grid.findGrid(sideBias);
    opposite = grid.findGrid(chooseEdge(sideBias*-1));
    
    while (opposite == location) {
      opposite = grid.findGrid(chooseEdge(sideBias*-1));
    }
  }

  void populateStringList() {
    details.append("ZET");
    //details.append("ROPER-BLACKMAN");
    details.append("ZROPERBLACKMAN.COM");
    details.append("07462737588");
    details.append("ZROPERBLACKMAN@GMAIL.COM");
  }

  void setTextSize(boolean flyer) {
    float minSize = 50;
    float maxSize = 120;
    
    if (flyer) {
      minSize = 30;
      maxSize = 70;
      orderAdjectives();
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
      cWidth =  1480;
      cHeight = 2100;
    }
    surface.setSize(cWidth, cHeight);
    background.resize(int(width*(random(lowerSF, upperSF))), 0);
    flyerPassageWidth = (cWidth-(4*margin))/2;
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
      lines.append(temp3);
    }
  }

  int setTextAlign(int z) {
    if (z == 1) {
      textAlign(LEFT, TOP);
      yOffset = offsetVal;
      return 1;
    } 
    if (z == 3) {
      textAlign(RIGHT, TOP);
      yOffset = offsetVal;
      return 1;
    } 
    if (z == 7) {
      textAlign(LEFT, BOTTOM);
      yOffset = -1*offsetVal;
      textSpacing = -1;
      return -1;
    } 
    if (z == 9) {
      textAlign(RIGHT, BOTTOM); 
      yOffset = -1*offsetVal;
      textSpacing = -1;
      return -1;
    } else {
      return 0;
    }
  }

  void draw() {
    surface.setSize(cWidth, cHeight);
    setTextAlign(int(location.z));
    imageMode(CENTER);
    image(background, x, y);
    // grid.draw();
    // fill(255, 0, 0);
    // ellipse(location.x, location.y, 20, 20);
    // fill(0, 255, 0);
    // ellipse(opposite.x, opposite.y, 20, 20);
    fill(text);
    if (!flyer) {
      textFont(universConB, forenameSize);
      text(forename, location.x, location.y);
      textFont(universConB, surnameSize);
      text(surname, location.x, location.y + yOffset);
    }
    if (flyer) {
      drawLines(lines, opposite, true);
      drawLines(details, location, false);
    }
  }

  void drawLines(StringList lines, PVector location, boolean showBlurb) {

    int totalOffset = 0;
    int textDir = setTextAlign(int(location.z));
    float size = 0;

    if (textDir > 0 && showBlurb) {
      size = getSize(flyerBlurb);
      textFont(universConB, size);
      text(flyerBlurb, location.x, location.y + totalOffset);
      totalOffset += size;
    }

    for (String line : lines) {
      size = getSize(line);
      textFont(universConB, size);
      text(line, location.x, location.y + totalOffset);
      if (textDir > 0) {
        totalOffset += size;
      } else {
        totalOffset -= size;
      }
    } 

    if (textDir < 0 && showBlurb) {
      size = getSize(flyerBlurb);
      textFont(universConB, size);
      text(flyerBlurb, location.x, location.y + totalOffset); 
      totalOffset -= size;
    }
  }


  float getSize(String subject) {
    float ammount;
    float tWidth = 0;
    textFont(universConB, tempSize);
    while (abs(flyerPassageWidth - tWidth) > 0.5) {
      ammount = max(0.1, abs(map((flyerPassageWidth - tWidth), 0, 3000, 0.5, 100)));
      textFont(universConB, tempSize);
      tWidth = textWidth(subject);
      if ( tWidth > flyerPassageWidth) {
        tempSize -= ammount;
      } else {
        tempSize += ammount;
      }
    }
    return tempSize;
  }
}
