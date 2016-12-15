class Controller {
  //private Hero hero;
  private final int mappingX[] = {
    0, 0, -1, 1
  };
  private final int mappingY[] = {
    1, -1, 0, 0
  };//private final int Direct[] = {0, 1, 2, 3};D,U,L,R.
  private final int dx[] = {//8近傍.
    0, 1, 0, -1, 0, 1, -1, -1, 1
  };
  private final int dy[] = {
    0, 0, -1, 0, 1, -1, -1, 1, 1
  };
  
  private ArrayList <Point>exqueue;

  public Controller() {
    // this.hero = new Hero();//コントローラで制御するCharacterクラスを生成しとく  すると、このコントローラで制御できるようになる.
    this.exqueue = new ArrayList();
  }


  public void present_Game() {
    gameController();
    action();
  }



  private void gameController() {//向きを決定するのは本当にこれのやり方でおｋ？
  }

  private void action() {//引数に(Character charac)と書きたい。でも現在Characterインタは未実装.
    if (keyPressed) {
      if (!isActionPressed) {//この条件で一歩ずつ進む。（２フレーム連続でこのif文に入ることは出来ない。）
        if (key == 'z') {
          println(hero.getDirect());
          seek(hero.getDirect());//heroが現在向いてる方向を調べる(草を刈る).
        } else if (key == 'e') {
          println("e button pressed!!!!");
          //explode(hero.getDirect());
          explode(hero.getPosX(), hero.getPosY());
        }
      }
      isActionPressed=true;
    } else {
      isActionPressed = false;
    }
  }

  private void seek(int dir) {//dir 0~1がy軸、2~3がx軸.
    effectMgr.setEffect(Const.IMAGE_SLASH, hero.getPosX() + mappingX[dir], hero.getPosY() + mappingY[dir]);
    if (stg.isGrass(hero.getPosX() + mappingX[dir], hero.getPosY() + mappingY[dir])) {
      stg.editTmp(hero.getPosY() + mappingY[dir], hero.getPosX() + mappingX[dir], 4);
    }
  }

  //再帰.
  private void explode(int x, int y) {
    for (int i = 0; i < 9; i++) {
      final int nx = x + dx[i];
      final int ny = y + dy[i];
      switch(stg.getTmp(ny, nx)) {
      case Const.IMAGE_KUSA:
        //this.exqueue.add(new Point(nx, ny));
        bfsKUSAmain(nx, ny);
        break;
      case Const.IMAGE_MIZU:
        //MIZU(nx, ny);//A
        stg.editTmp(ny, nx, Const.IMAGE_TUTI);
        break;
      case Const.IMAGE_HASU:
        //HASU(nx, ny);//B    AとBをコメントアウトすると、バグアリ。留意すること.
        stg.editTmp(ny, nx, Const.IMAGE_MIZU);
        break;
      case Const.IMAGE_ICE:
        //ICE(nx, ny);
        stg.editTmp(ny, nx, Const.IMAGE_MIZU);
        break;
      default:
        break;
      }
    }
  }

  //キューによる幅優先探索のフラッドフィルアルゴリズム.
  private void bfsKUSA(int x, int y) {
    stg.editTmp(y, x, Const.IMAGE_TUTI);//like visited flag.
    for (int i = 1; i < 5; i++) {//燃えた草に隣接しているパネルが...
      if (stg.isGrass(x + dx[i], y + dy[i]) || stg.isIce(x + dx[i], y + dy[i])) {// 草だったら、氷だったら、
        if (stg.isIce(x + dx[i], y + dy[i])) {
          stg.editTmp(y + dy[i], x + dx[i], Const.IMAGE_MIZU);
        }
        this.exqueue.add(new Point(x + dx[i], y + dy[i]));//連鎖用の幅優先探索用 兼 エフェクト用のキューに突っ込むのは、隣接パネルが草のときのみ。氷は突っ込まない。これで氷は草からしか連鎖できない。
      }
    }
  }

  private void bfsKUSAmain(int x, int y) {
    bfsKUSA(x, y);
    //this.exqueue.add(new Point(x, y));//Heroの座標のエフェクト.
    stg.drawPanel(hero.getPosX(), hero.getPosY());
    hero.drawImg();
    while (this.exqueue.size () > 0) {
      Point tmp = this.exqueue.get(0);
      this.exqueue.remove(0);
      effectMgr.setEffect(Const.IMAGE_EXPLODE, tmp.x, tmp.y);
      if (stg.isGrass(tmp.x, tmp.y)) {
        bfsKUSA(tmp.x, tmp.y);
      }
    }
  }


  //  private void MIZU(int x, int y){
  //    stg.editTmp(y, x, tuti);
  //    for(int i = 0; i < 4; i++){
  //      if(stg.isMizu(x + dx[i], y + dy[i])) MIZU(x + dx[i], y + dy[i]);
  //    }
  //  }
  //  private void HASU(int x, int y){
  //    stg.editTmp(y, x, tuti);
  //    for(int i = 0; i < 4; i++){
  //      if(stg.isHasu(x + dx[i], y + dy[i])) HASU(x + dx[i], y + dy[i]);
  //    }
  //  }
  //  private void ICE(int x, int y){
  //    stg.editTmp(y, x, tuti);
  //    for(int i = 0; i < 4; i++){
  //      if(stg.isIce(x + dx[i], y + dy[i])) ICE(x + dx[i], y + dy[i]);
  //    }
  //  }
}



class Point {
  public int x;
  public int y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

