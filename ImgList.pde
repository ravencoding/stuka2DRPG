//全ての画像をloadImageして、保持するクラス.
//チップ画像はchipImg[]に、Heroの画像はheroImg[]で保持する.
public class ImgList{
  private PImage chipImgs[] = new PImage[Const.CHIP_NAMES.length];
  private PImage heroImgs[] = new PImage[Const.HERO_CHIP_NAMES.length];//基本、上下左右の四要素。+ 武器持ってる画像etc.
  private PImage effectImgs[] = new PImage[Const.EFFECT_NAMES.length];
  private PFont font;




  //コンストラクタ.
  public ImgList() {//Processingは入れ子クラスなのでひとまずシングルトン考えなくてよい → staticからpublicに変更した.
    initImg();
  }
  
//  public static ImgList getImgListInstance(){
//    if(singleInstance == null){
//      this.singleInstance = new ImgList();
//    }
//    return singleInstance;
//  }

  //bmpから画像を取得する.
  private void initImg() {
    for (int i = 0; i < Const.CHIP_NAMES.length; i++) {
      this.chipImgs[i] = loadImage(Const.CHIP_NAMES[i] + ".bmp");
    }

    //Heroの画像を取得する.
    for (int i = 0; i < Const.HERO_CHIP_NAMES.length; i++) {
      this.heroImgs[i] = loadImage(Const.HERO_CHIP_NAMES[i] + ".png");
    }
    
    //エフェクトの画像を取得する.
    for(int i = 0; i < Const.EFFECT_NAMES.length; i++){
      this.effectImgs[i] = loadImage(Const.EFFECT_NAMES[i] + ".png");
    }
    
    this.font = createFont("TanukiMagic.ttf", 32);
    textFont(font);
  }
  
  public PImage getChipImg(int numbering) {
    return this.chipImgs[numbering];
  }
  public PImage getHeroImg(int numbering){
    return this.heroImgs[numbering];
  }
  public PImage getEffectImg(int imgID){
    return this.effectImgs[imgID];
  }
}
