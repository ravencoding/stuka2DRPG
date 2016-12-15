class MainMenu implements State {
  public void draw() {
    //background(200);
    fill(0);
    textSize(18);
    textAlign(CENTER);
    text(Const.TITLE, width/2, height/2);
    text("Nボタンを押すとスタート", width/2, height/2 + 80);
    text("すつーか", width/2, height/2 + 160);
  }

  public int operator() {
    if (keyPressed) {
      if (!isPressed) {
        if (key == 'n') {
          println("to Game");
          isPressed = true;
          stg.setStage(10);
          stg.drawImg();
          hero.drawImg();
          return 1;
        }
      }
    }else isPressed = false;
    return 0;
  }
}

