public class Hero {
  private int pos_x = 1;
  private int pos_y = 1;
  private int pixel_x = pos_x * Const.CHIP;
  private int pixel_y = pos_y * Const.CHIP;
  private final int Direct[] = {
    0, 1, 2, 3
  };//D,U,L,R
  private int direct = 0;//いちおうDOWNで初期化.

  public Hero() {
  }

  public void drawImg() {
    image(imgLst.getHeroImg(this.getDirect()), pixel_x, pixel_y, Const.CHIP, Const.CHIP);
  }

  public void increPos(int delta_x, int delta_y) {
    this.pixel_x = pos_x * Const.CHIP;
    this.pixel_y = pos_y * Const.CHIP;
  }
  public void move(int x, int y) {
    this.pixel_x += x;
    this.pixel_y += y;
  }

  public void setDirect(int dir) {
    this.direct = Direct[dir];
  }
  public int getDirect() {//コントローラ改善にあたりprivateからpublicに変更.
    return direct;
  }

  public int getPosX() {
    return pos_x;
  }
  public int getPosY() {
    return pos_y;
  }
  public void pixelRefresh() {
    this.pos_x = (pixel_x  + Const.CHIP / 2) / Const.CHIP;
    this.pos_y = (pixel_y  + Const.CHIP / 2) / Const.CHIP;
  }
  
  public void setPos(int posx, int posy){
    this.pos_x = posx;
    this.pos_y = posy;
    this.pixel_x = Const.CHIP;//ここを2行コメントアウトすると、
    this.pixel_y = Const.CHIP;//直前にゲームオーバーになったポジションにリスタート時描画される（描画だけで座標は1,1）.
  }
}



class MovingAnimation implements State {
  final int speed = 5;//1～CHIPサイズまで（例：CHIP＝30のとき、1～30）
  private int flame = 0;
  final int dx[] = {
    0, 0, -1, 1
  }
  , dy[] = {
    1, -1, 0, 0
  };//D,U,L,R.

  public void draw() {
    this.flame++;

    hero.move(dx[hero.getDirect()] * Const.CHIP / speed, dy[hero.getDirect()]* Const.CHIP / speed);
    stg.drawPanel(hero.getPosX(), hero.getPosY());//移動元のパネルを描画.
    stg.drawPanel(hero.getPosX() + dx[hero.getDirect()], hero.getPosY() + dy[hero.getDirect()]);//移動先のパネルを描画.
    hero.drawImg();
    println(dx[hero.getDirect()] * Const.CHIP / speed);
  }
  public int operator() {
    if (flame == speed) {
      this.flame = 0;
      hero.pixelRefresh();
      if(stg.isMizu(hero.getPosX(), hero.getPosY())){//池ポチャでゲームオーバーに.
        return 5;//gotoGameOver.
      }
      if ( (  stg.isIce(hero.getPosX(), hero.getPosY()) ) && 
              !stg.isWall(hero.getPosX() + dx[hero.getDirect()], hero.getPosY() + dy[hero.getDirect()] )
             || stg.isMizu(hero.getPosX() + dx[hero.getDirect()], hero.getPosY() + dy[hero.getDirect()]) && //池ポチャ.
                stg.isIce(hero.getPosX(), hero.getPosY()) //池ポチャ.
              ) {
        return 4; //氷パネルの上を滑る処理.
      }
      return 1;//gotoGame
    } else {
      return 4;//gotoMovingAnimation
    }
  }
}

