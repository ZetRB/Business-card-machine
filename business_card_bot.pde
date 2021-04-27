import java.util.Date;
import processing.pdf.*;
Card[] cards;
color[] colourScheme;
int cardCount = 10;
int canvasX = 1000;
int canvasY = int(canvasX/1.61);
int imagePool = 1;//how many images there are to choose from
PImage[] sample;
PFont universConB, universLight;
boolean preview = true; // set to true to check settings and generate 1 card
boolean flyer = true;
StringList doingWords = new StringList(); 


color brightest = #000000;
color saturated = #000000;

void setup() {
  if (preview) {
    cardCount = 1;
  } 
  //size(1000, 618, PDF, "test.pdf");
  surface.setSize(1000, 618);
  fonts();
  findImages();
  //showColours();  
  makeCards();
  noLoop();
}

void fonts() {
  universConB = createFont("UniversLTPro-BoldCond.ttf", 80); 
  universLight = createFont("UniversLTPro-45Light.ttf", 50);
}

void makeCards() {

  cards = new Card[cardCount]; // working on making it loop through however number of cards it wants to make
  for (int i = 0; i < cardCount; i++) {
    int x = int(random(0, imageNames.size()));
    String cardName = imageNames.get(x);
    getWords();
    cards[i] = new Card(cardName, flyer, doingWords);

  }
}

void draw() {
  // PGraphicsPDF pdf = (PGraphicsPDF) g;
  for (Card card : cards) {
    card.draw();
    saveFrame("output/sample-###.png");
    if (!preview) {
      // pdf.nextPage();
    }
  }
  // endRecord();
  exit();
}
