StringList imageNames = new StringList();
 String[] tempNames;
void findImages() {
  String path = dataPath(""); // finds list of images, transfers the string[] to an arrayList for deletion
  println(path);
  tempNames = listFileNames(path);
  for (String name : tempNames) {
    if (name.charAt(name.length()-1) == 'g' && name.charAt(name.length()-2) == 'p' && name.charAt(name.length()-3) == 'j') {
      imageNames.append(name);
    }
  }
  printArray(imageNames);
}

String[] listFileNames(String dir) {
  println("looking for files");
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    
    return names;
  } else {
    println("fileNotFound");
    // If it's not a directory
    return null;
  }
}
