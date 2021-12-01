class Data {
  double total1, total2, acumulate, APE, t1 ,t2;
  Map<String, List<List<String>>> mp = {};
  Data(this.total1, this.total2, this.acumulate , this.APE , this.t1, this.t2) {
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

   void sett1(x) {
    t1 = x;
  }
   void sett2(x) {
    t2 = x;
  }

  void setAPE(x) {
    APE = x;
  }

  void setTotal1(x) {
    total1 = x;
  }

  void setTotal2(x) {
    total2 = x;
  }

  double getTotal1() => total1;

  double getTotal2() => total2;

  double getAPE() => APE;

  double getT1() => t1;
  
  double getT2() => t2;

  double getEfec() {
    double res = 0 ; 

    if(mp['a1']!.isNotEmpty){
      if(mp['a1']![4][0] != '')
       res = double.parse( mp['a1']![4][0]);
    }

    return res; 
  }

  void addList(key, List<List<String>> v) {
    mp[key] = v;
  }

  List<List<String>> getList(s) {
    return mp[s]!;
  }

 List<String> getAporteList()
  { 
    List<String >ls = [] ; 
    // mp.forEach((key, value) {
    //   double res = 0; 
    //   value.forEach((element) {
    //     if(element.length > 4)
    //     res += double.tryParse(element[4])!;  
    //    });
    //   ls.add(res.toStringAsFixed(2)); 
    //  });
    mp.forEach((key, value) {
      double res = 0 ; 
      if(value.isNotEmpty )
      value[4].forEach((element) {
        if(element != ''){
          res += double.tryParse(element)!; 
        }
      });
      ls.add(res.toStringAsFixed(2)); 

     }); 

     return ls; 
  }

 List<String> getInvertidoList()
  { 
    List<String >ls = [] ; 
    // mp.forEach((key, value) {
    //   double res = 0; 
    //   value[3].forEach((element) {
    //     if(element.length>5 )
    //     res += double.tryParse(element[5])!;  
    //    });
    //   ls.add(res.toStringAsFixed(2)); 
    //  });

    mp.forEach((key, value) {
      double res = 0 ; 
      if(value.isNotEmpty )
      value[5].forEach((element) {
        if(element != ''){
          res += double.tryParse(element)!; 
        }
      });
      ls.add(res.toStringAsFixed(2)); 

     }); 
      ls.removeAt(0);
     return ls; 
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
