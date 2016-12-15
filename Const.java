public class Const {
  public static final int CHIP = 30;
  public static final int MASU_X = 16;
  public static final int MASU_Y = 16;
  public static final int STAGE_NUM = 11;//1からカウントして、ステージの個数を指定する #マップの追加があれば随時変更すること.

  public static final int IMAGE_KUSA = 0;
  public static final int IMAGE_KABE = 1;
  public static final int IMAGE_ICE = 3;
  public static final int IMAGE_MIZU = 2;
  public static final int IMAGE_HASU = 5;
  public static final int IMAGE_TUTI = 4;
  public static final int IMAGE_EXPLODE = 0;
  public static final int IMAGE_SLASH = 1;
  
  public static final String TITLE = "Project stuka";
//  public static final String TITLE_MSG = "Nボタンを押すとスタート";

  public static final String CHIP_NAMES[] = {//ココは逐一追加･改変すること.
    "kusa", "stone3", "mizu1", "ice", "tuti", "mizu2"
  };
  public static final String HERO_CHIP_NAMES[] = {//ココは逐一追加･改変すること.
    "heroD", "heroU", "heroL", "heroR"
  };
  public static final String EFFECT_NAMES[] = {
    "explode", "slashred"
  };
  public static final int ATLAS_COLUMNS[] = { //エフェクトの元画像の列数.
    8, 9
  };
  public static final int ATLAS_ROWS[] = { //エフェクトの元画像の行数.
    2, 1
  };
  public static final int FRAME_LIMITS[] = { //エフェクトの元画像のフレーム数.
    15, 9
  };
  public static final int EFFECT_CHIPS[] = { //エフェクトの元画像の１マス分のピクセル数.
    96, 120
  };
}

