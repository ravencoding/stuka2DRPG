public class Stage{
  private Map allMaps[];//二次元配列であるintMapを保持するため、実質三次元.   //allMaps = {Mapクラス, Mapクラス,,,}.
  private int nowStage = 0;//現在プレイしているステージが何番目のステージかを保持する.
  private Map tmp;//現在のマップのチップ状態を保持する.
  
  //コンストラクタ.
  public Stage(){
    loadAllMaps();
  }
  
  private void loadAllMaps(){
    allMaps = new Map[Const.STAGE_NUM];
    for(int i = 0; i < Const.STAGE_NUM; i++){
      allMaps[i] = lexerCSVtoMap(i);//2dから3dへ.
    }
  }
  
  //引数で指定したステージのcsvファイルをint型の配列で保持する.
  private Map lexerCSVtoMap(int n){
    String stringMap[] = loadStrings("map" + n + ".csv");//改行ごとに配列に格納するメソッド.
    String tmp[] = split(stringMap[0], ",");//二次元目の要素数を求めるために用意.
    String stringMap2d[][] = new String[stringMap.length][tmp.length];

    Map intMap = new Map(stringMap.length, tmp.length);//intMapクラスのフィールドに2d配列がある.

    for (int i = 0; i < stringMap.length; i++) {
      stringMap2d[i] = split(stringMap[i], ",");//1dから2dへ.
    }

    //String型をint型に変換.
    for (int i = 0; i < stringMap2d.length; i++) {//y
      for (int k = 0; k < tmp.length; k++) {//x
        intMap.setValue(i, k, Integer.parseInt(stringMap2d[i][k]));
      }
    }
    return intMap;
  }
  
  public void drawImg(){
    //tmp = allMaps[nowStage];//これでtmpに現在のステージのMapが保存された。以降、tmpに参照されたチップの値を変えても、allMapsのMapの値は変えない(allMapsは定数として扱う).
    for(int i = 0; i < Const.MASU_Y; i++){
      for(int k = 0; k < Const.MASU_X; k++){
        image(imgLst.getChipImg(this.tmp.getValue(i, k)), k * Const.CHIP, i * Const.CHIP, Const.CHIP, Const.CHIP);//いつかラップするつもり.
      }
    }
  }
  
  public void drawPanel(int x, int y){
    image(imgLst.getChipImg(this.tmp.getValue(y,x)), x * Const.CHIP, y * Const.CHIP, Const.CHIP, Const.CHIP);
  }
  
  public void setStage(int n){
    this.tmp = copyMap(allMaps[n]);
//    if(n + 1 <= stageNum && n + 1 >= 0) this.nowStage = n;//存在するステージナンバーならば.
//    else println("そのステージナンバーは存在しません.\n デフォルトでステージ0を表示します");
  }
  /*
   * Map.clone()が効かずに.定数であるはずのallMapsの値が変わってしまっていたので、
   * 値を指定して新しくインスタンスを作成するメソッドを用意.
   */
  private Map copyMap(Map map){
    Map tmp = new Map(map.getAxisY(), map.getAxisX());
    for(int y = 0; y < tmp.getAxisY(); y++){
      for(int x = 0; x < tmp.getAxisX(); x++){
        tmp.setValue(y, x, map.getValue(y, x));
      }
    }
    return tmp;
  }
  
  //isWall判定用に追加.
  //柱と水.
  public boolean isWall(int x,int y){
    int id = this.tmp.getValue(y, x);
    if(id == 1 || id == 2) return true;
    else return false;
  }
  public boolean isGrass(int x, int y){
    if(this.tmp.getValue(y, x) == 0) return true;
    else return false;
  }
  public boolean isMizu(int x, int y){
    if(this.tmp.getValue(y, x) == 2) return true;
    else return false;
  }
  public boolean isIce(int x, int y){
    if(this.tmp.getValue(y, x) == 3) return true;
    else return false;
  }
  public boolean isHasu(int x, int y){
    if(this.tmp.getValue(y, x) == 5) return true;
    else return false;
  }
  
  public void editTmp(int y, int x, int value){
    this.tmp.setValue(y, x, value);
  }
  
  public int getTmp(int y, int x){
    return this.tmp.getValue(y, x);
  }
}
