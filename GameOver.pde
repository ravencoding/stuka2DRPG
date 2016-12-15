class GameOver implements State {
  public void draw() {
    textSize(18);
    textAlign(CENTER);
    text("ゲームオーバー", width/2, height/2);
    text("Rボタンでタイトルへ", width/2, height/2 + 80);
  } 
  public int operator() {
    if (keyPressed) {
      if (!isPressed) {
        if (key == 'r') {
          println("to Title");
          isPressed = true;
          background(255);
          hero.setPos(1,1);
          return 0;
        }
      }
    }else isPressed = false;
    return 5;
  }
}

