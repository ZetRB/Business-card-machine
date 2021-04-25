import java.util.Date;
Card card;
color[] colourScheme;
int canvasX = 1000;
int canvasY = int(canvasX/1.61);
int imagePool = 1;//how many images there are to choose from
PImage[] sample;

  color brightest = #000000;
  color saturated = #000000;

void setup(){
  size(1000,600);
  findImages();
  establishColourScheme();
    //showColours();  
    makeCards();

}

void makeCards(){
  int random = int(random(0,imageNames.size()));
  String cardName = imageNames.get(random);
  card = new Card(cardName, brightest, saturated);
}

void draw(){
card.draw();
}
