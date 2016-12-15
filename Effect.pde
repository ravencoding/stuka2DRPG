public class EffectManager {
  ArrayList <EffectAnimation>effectList;
  private int chain = 1;

  public EffectManager() {
    this.effectList = new ArrayList();
  }

  /*
   * 画像IDと座標でエフェクトを生成して、エフェクト描画キューに入れる.
   */
  public void setEffect(int imgID, int posx, int posy) {
    EffectAnimation effect = new EffectAnimation();
    effect.setUp(imgID, posx, posy);
    this.effectList.add(effect);
  }


  /*
   * effectListに追加されているエフェクトを1フレームだけ描画する。
   */
  public void effectPlay() {
    if (this.effectList.size() > 0 ) {
      for (int i=0; i < chain && i < this.effectList.size (); i++) {
        this.effectList.get(i).draw();
      }
      effectReflesh();
      chain++;
    }else if (this.effectList.size() == 0){
      chain = 1;
    }
  }

  /* 
   * 再生が終了したエフェクトをArrayListからremoveする.
   */
  private void effectReflesh() {
    for (int i = 0; i < this.effectList.size (); i++) {
      if (this.effectList.get(i).stateId == 0) {
          EffectAnimation tmp = this.effectList.get(i);
          stg.drawPanel(tmp.getX(), tmp.getY());//エフェクト終了後にパネルを描画.
//          hero.drawImg();
          this.effectList.remove(i);
      }
    }
  }
}


public class EffectAnimation {
  public Effect stateList[] = {
    new NonEffect(), new Effect()//エフェクト再生後状態, エフェクト描画中状態.
    };
    private State state;
  public int stateId;

  public EffectAnimation() {
    stateId = 1;
    state = stateList[stateId];
  }

  /*
   * drawとoperatorをひとまとめにしている.
   */
  public void draw() {
    state.draw();
    stateId = state.operator();
    state = stateList[stateId];
  }
  /*
   * EffectクラスのsetImage()とsetPosition()に委譲している.
   */
  public void setUp(int imgID, int posx, int posy) {
    stateList[1].setImage(imgID);
    stateList[1].setPosition(posx, posy);
  }
  public int getX() {
    return stateList[1].getX();
  }
  public int getY() {
    return stateList[1].getY();
  }
}


/*
 * エフェクトの最後のフレーム画像を描画すると、NonEffectに遷移する.
 */
public class Effect implements State {
  private int counter = 0;
  private int posx;
  private int posy;
  private int imgID = 0;// explodeのIDで初期化.
  private int imgCHIP = 96;//explodeのピクセル数で仮に初期化.
  private int atlasX = 8;//explodeの列数で仮に初期化.
  private int atlasY = 2;//explodeの行数で仮に初期化.
 

  final int frame_limit = 15;
  private int frame = 0;

  public Effect() {//画像読み込み系はシングルトンクラスでやる予定.
  }

  public void draw() {
    drawOneFlame();
    frame++;
  }
  public int operator() {
    if (frame == Const.FRAME_LIMITS[this.imgID]) {
      frame = 0;
      counter = 0;
      return 0;
    } else return 1;
  }

  void drawOneFlame() {
    int offsetx = (counter % atlasX) * imgCHIP;
    int offsety = ((counter / atlasX) % atlasY) * imgCHIP;
    image(imgLst.getEffectImg(this.imgID).get(offsetx, offsety, imgCHIP, imgCHIP), posx * Const.CHIP, posy * Const.CHIP, Const.CHIP, Const.CHIP);
    counter++;
  }

  public void setPosition(int posx, int posy) {
    this.posx = posx;
    this.posy = posy;
  }
  public void setImage(int imgID) {
    this.imgID = imgID;
    this.imgCHIP = Const.EFFECT_CHIPS[imgID];
    this.atlasX = Const.ATLAS_COLUMNS[imgID];
    this.atlasY = Const.ATLAS_ROWS[imgID];
  }

  public int getX() {
    return this.posx;
  }
  public int getY() {
    return this.posy;
  }
}



/*
 * エフェクト再生終了時に状態遷移するState実装.
 * (EffectAnimation#setPosition()を委譲するためにEffectを継承している.
 */
class NonEffect extends Effect {
  public int operator() {
    return 0;
  }

  public void draw() {
    //nothing.
  }
}

