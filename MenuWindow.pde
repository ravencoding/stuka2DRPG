class MenuWindow implements State {
  public void draw() {
    fill(255);
    rect(20, 20, Const.CHIP * 10, Const.CHIP * 4);
    fill(0);
    rect(25, 25, Const.CHIP * 10 - 10, Const.CHIP * 4 - 10);
    
    fill(255);
    text("アイテム", 80, 50);
    text("とじる", 66, 90);
  } 
  public int operator() {
    if (keyPressed) {
      if (!isPressed) {
        if (key == 'm') {
          println("to Game");
          isPressed = true;
          return 1;
        }
      }
    }else isPressed = false;
    return 2;
  }
}

