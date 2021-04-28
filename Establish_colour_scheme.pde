color[] establishColourScheme(String chosenImage){
//hi
  int gridX = 20;
  int gridY = 20; //set colour finder grid size
  
  colourScheme = new color[gridX*gridY];
 
// int random = int(random(0,imageNames.size()));
 PImage sample = loadImage(chosenImage);
 println("image chosen = " + chosenImage);
 sample.loadPixels(); // choose random image to derive colour scheme
 
 int w = sample.width;
 //println(w);
 int h = sample.height;
 //println(h);
 
 for(int y = 0; y < gridY; y++){
  for (int x = 0; x < gridX; x++){
    colourScheme[(y*gridX) + x] = sample.pixels[int(((x+0.5)*w/gridX) + ((y+0.5)*h))];
   // println("colur at pixel[ " + int(((x+0.5)*w) + ((y+0.5)*h)) + " ]");
  }
 }
  for (color colour : colourScheme){
    if (saturation(colour) > saturation(saturated)){
     saturated = colour;
    }
    if (brightness(colour) > brightness(brightest)){
     brightest = colour; 
    }
  }
  
  color[] picked = new color[2];
  picked[0] = #FFFFFF;
  picked[1] = saturated;
  
  return picked;
 
 
}

void showColours(){
  int x = 0;
  fill(brightest);
  rect(width/2-100,200,100,100);
  fill(saturated);
  rect(width/2+100,200,100,100);
  
  for(color colour : colourScheme){
    fill(colour);
   rect(width/colourScheme.length*x, 100, width/colourScheme.length,50);
   stroke(100);
   x+=1;
  }
}
