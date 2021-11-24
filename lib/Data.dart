class Data {
  double total1, total2, acumulate;
  Map<String, List<List<String>>> mp = {};
  Data(this.total1, this.total2, this.acumulate) {
    mp = {
      'a1': [],
      'a': [],
      'b': [],
      'c': [],
      'd': [],
      'e': [],
      'f': [],
      'g': [],
    };
  }

  void setTotal1(x) {
    total1 = x;
  }

  void setTotal2(x) {
    total2 = x;
  }

  double getTotal1() => total1;

  double getTotal2() => total2;

  void addList(key, List<List<String>> v) {
    mp[key] = v;
  }

  List<List<String>> getList(s) {
    return mp[s]!;
  }

 

  bool exceed() {
    double sum = 0;
    double sum2 = 0;

    mp.forEach((key, value) {
      value[3].forEach((element) {
        sum += double.tryParse(element)!;
      });
      value[4].forEach((element) {
        sum2 += double.tryParse(element)!;
      });
    });
    return total1 < sum || total2 < sum2;
  }

  double getTotalAporte(){
    double res = 0 ; 
    mp.forEach((key, value) {
      if(value.isNotEmpty )
      value[3].forEach((element) {
        if(element != ''){
          res += double.tryParse(element)!; 
        }
      });

     }); 

    return res ; 
  }
  

  double calc(List<String> ls ,int  index ){
    double res = 0 ; 
  
    ls.forEach((element) { 
      var grid= mp[element];

    if(grid!.isNotEmpty){
      grid[index].forEach((element) {
        if(element != ''){
          res += double.tryParse(element)!; 
        }

       });
    }
    });
    return res ; 
  }

  double getAporte1 (){
       
      var values = ['a1','a','b','c', 'd'];
          return calc(values , 4);  
  }
  double getInvertido1 (){
    
    var values = ['a1','a','b','c', 'd'];
    return calc(values , 5); 
  }
  double getAporte2  (){
     
    var values = ['e','g','f'];
    return calc(values , 4); 
  }
  double getInvertido2 (){
    
    var values = ['e','g','f'];
    return calc(values , 5); 
  }
}
