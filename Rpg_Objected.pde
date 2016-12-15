private ImgList imgLst;//static.
private State state;
private State stateList[] = {
  new MainMenu(), new Game(), new MenuWindow(), new Pause(), new MovingAnimation(), new GameOver()
  };//メインメニュー, ゲーム画面, メニューウィンドウ
  private boolean isPressed = false;
private boolean isActionPressed = false;
private Stage stg;//static.
private Controller cntroller;
Hero hero;
private EffectManager effectMgr;

public void setup() {
  size(Const.CHIP * Const.MASU_X, Const.CHIP * Const.MASU_Y);
  imgLst = new ImgList(); //全てのloadImg("")を実行.
  effectMgr = new EffectManager();
  stg = new Stage();
  cntroller = new Controller();
  stg.setStage(10);//引数は0以上.
  state = stateList[0];//デバグとしてhogehoge画面で初期化することが可能.
  hero = new Hero();
  
  background(255);
}

public void draw() {
  state = stateList[state.operator()];
  state.draw();
  effectMgr.effectPlay();
}

