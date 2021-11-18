class Data {
  double total1 , total2 , acumulate; 
  Map<String , List<Map<String,dynamic>>> mp = {};
  Data(this.total1 , this.total2 , this.acumulate)
  {
    mp= { 
      'a': [],
      'b': [],
      'c': [],
      'd': [],
      'e': [],
      'f': [],
      'g': [],
    }; 
  }

  void setTotal1( x )
  {
    total1 = x; 
  } 
  void setTotal2( x )
  {
    total2 = x; 
  } 

  double getTotal1() => total1;
  
  double getTotal2() => total2;
   
  void addList( key , List<Map<String,dynamic>> v ){
    mp[key] = v; 
  }

  List<Map<String,dynamic>> getList( s ){
    return mp[s]!; 
  }

  bool exceed(){
    double sum = 0 ;
    double sum2 = 0 ;

    mp.forEach((key, value) { 
      value.forEach((element) {

        sum += element['Aporte Propio']!;
        sum2+= element['Invertido'];
      });


    });  
    return total1 < sum || total2 < sum2;
  }
}