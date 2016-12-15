class Game implements State {
  public void draw() {
    //println("drawなう");
    //stg.drawImg();
    cntroller.present_Game();
    
  }
  boolean antichoco = false;
  public int operator() {
    if (keyPressed) {
      if (!isPressed) {
        if(!antichoco){
        if (keyCode == UP) {
          if (!stg.isWall(hero.getPosX(), hero.getPosY() - 1) && hero.getDirect() == 1) {
            hero.increPos(0, -1);
            return 4;
          }else{
            hero.setDirect(1);
            antichoco = true;
          }
        }
        else if (keyCode == DOWN) {
          if (!stg.isWall(hero.getPosX(), hero.getPosY() + 1) && hero.getDirect() == 0) {
            hero.increPos(0, 1);
            return 4;
          }else{
            hero.setDirect(0);
            
            antichoco = true;
          }
        }
        else if (keyCode == RIGHT) {
          
          if (!stg.isWall(hero.getPosX() + 1, hero.getPosY()) && hero.getDirect() == 3) {
            hero.increPos(1, 0);
            return 4;
          }else{
            hero.setDirect(3);
            antichoco = true;  
          }
        }
        else if (keyCode == LEFT) {
          
          if (!stg.isWall(hero.getPosX() - 1, hero.getPosY()) && hero.getDirect() == 2) {
            hero.increPos(-1, 0);
            return 4;
          }else{
            hero.setDirect(2);
            antichoco = true;
          }
        }
        }
        if (key == 'm') {
          println("to MenuWindow");
          isPressed = true;
          return 2;
        }
        if (key == 'p') {
          println("to Pause");
          isPressed = true;
          return 3;
        }      
        //stg.drawImg();
        hero.drawImg();
      }
    }else{
      isPressed = false;
      antichoco = false;
    }
    return 1;
  }
}


