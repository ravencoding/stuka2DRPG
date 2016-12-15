public class Map{
  private int intMap[][];
  
  //コンストラクタ.
  public Map(int axis_y, int axis_x){
    this.intMap = new int[axis_y][axis_x];
  }
  
  public int getValue(int y, int x){
    return intMap[y][x];
  }
  
  public void setValue(int y, int x, int value){
    this.intMap[y][x] = value;
  }
  
  public int getAxisX(){
    return this.intMap[0].length;
  }
  public int getAxisY(){
    return this.intMap.length;
  }
}
