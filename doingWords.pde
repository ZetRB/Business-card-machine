

void getWords(){
 String[] adjectives = loadStrings("doingWords.txt");
 
 for(String word: adjectives){
  doingWords.append(word); 
 }
}
