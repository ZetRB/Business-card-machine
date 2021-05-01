import java.util.Date;
import processing.pdf.*;
Card[] cards;
color[] colourScheme;
int totalCount = 10;
int flyerCount = 0;
int count = 0;
int imagePool = 1;//how many images there are to choose from
PImage[] sample;
PFont universConB, universLight;
boolean preview = false; // set to true to check settings and generate 1 card
boolean flyer = false;
StringList doingWords = new StringList(); 
int current = 0;


color brightest = #000000;
color saturated = #000000;

void setup() {
  if (preview) {
    totalCount = 1;
  } 
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

  cards = new Card[totalCount]; // working on making it loop through however number of cards it wants to make
  for (int i = 0; i < totalCount; i++) {
    if (i >= totalCount-flyerCount) {
      flyer = true;
    }
    int x = int(random(0, imageNames.size()));
    String cardName = imageNames.get(x);
    getWords();
    cards[i] = new Card(cardName, flyer, doingWords);
  }
}

void draw() {

  for (Card card : cards) {
    card.draw();
    if (card.flyer) {
      saveFrame("flyer/flyer-" + flyerCount + ".png"); 
      println("Saving :" + "flyer/flyer-" + flyerCount + ".png\n");
      flyerCount++;
    } else {
      saveFrame("card/card-" + count + ".png");
      println("Saving :" + "card/card-" + count + ".png\n");
      count++;
    }
  }
  exit();
}
