class Pause implements State {
  public void draw() {
    fill(0);
    textSize(18);
    textAlign(CENTER);
    text("Pause", width/2, height/2);
    text("Press the P button to Resume!", width/2, height/2 + 80);
  } 
  public int operator() {
    if (keyPressed) {
      if (!isPressed) {
        if (key == 'p') {
          println("Resume !");
          isPressed = true;
          stg.drawImg();
          hero.drawImg();
          return 1;
        }
      }
    }else isPressed = false;
    return 3;
  }
}

