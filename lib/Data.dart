import 'package:flutter/cupertino.dart';

class Data with ChangeNotifier {
  double total1,
      total2,
      total3,
      APE,
      t1,
      t2,
      totalVentas,
      MUB,
      costos,
      TG,
      avion,
      ruta,
      frecuencia = 30,
      MF,
      TVentas,
      TCostos,
      poliza,
      cuotaAprox,
      capacidadPago,
      solvencia,
      otros,
      cajaDeAhorro,
      desembolso1 = 0,
      desembolso2 = 0,
      ingresosTotales = 0;
  String actividad, cuota;
  Map<String, List<List<String>>> mp = {};
  Data(
      this.total1,
      this.total2,
      this.total3,
      this.APE,
      this.t1,
      this.t2,
      this.TG,
      this.MUB,
      this.costos,
      this.totalVentas,
      this.actividad,
      this.avion,
      this.ruta,
      this.cuota,
      this.MF,
      this.TVentas,
      this.TCostos,
      this.poliza,
      this.cuotaAprox,
      this.capacidadPago,
      this.solvencia,
      this.otros,
      this.cajaDeAhorro) {
    mp = {
      'a1': List.generate(6, (index) => List.generate(20, (index) => '')),
      'a': List.generate(6, (index) => List.generate(20, (index) => '')),
      'b': List.generate(6, (index) => List.generate(20, (index) => '')),
      'c': List.generate(6, (index) => List.generate(20, (index) => '')),
      'd': List.generate(6, (index) => List.generate(20, (index) => '')),
      'e': List.generate(6, (index) => List.generate(20, (index) => '')),
      'f': List.generate(6, (index) => List.generate(20, (index) => '')),
      'g': List.generate(6, (index) => List.generate(20, (index) => '')),
    };
  }

  void setTVentas(double x) {
    TVentas = x;
  }

  void setTCostos(double x) {
    TCostos = x;
  }

  void setpoliza(x) {
    poliza = x;
  }

  void setcuotaAprox(x) {
    cuotaAprox = x;
  }

  void sett1(x) {
    t1 = x;
  }

  void sett2(x) {
    t2 = x;
    setMF();
  }

  void setTotalVentas(x) {
    totalVentas = x;
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

  void setTotal3(x) {
    total3 = x;
    setMF();
  }

  void setMUB(x) {
    MUB = x;
  }

  void setCostos(x) {
    costos = x;
  }

  void setTG(x) {
    TG = x;
  }

  void setIngresosTotales(x) {
    ingresosTotales = x;
  }

  double getIngresosTotales() => ingresosTotales;
  void setDesembolso(double val, int i) {
    if (i == 0)
      desembolso1 = val;
    else
      desembolso2 = val;
  }

  void setFrecuencia(double f) {
    frecuencia = f;
    notifyListeners();
  }

  void setActividad(String f) {
    print("actividad cambiada a $f");
    actividad = f;
    notifyListeners();
  }

  void setAvion(double f) {
    avion = f;
    notifyListeners();
  }

  void setRuta(double f) {
    ruta = f;
    notifyListeners();
  }

  void setCuota(String f) {
    cuota = f;
    notifyListeners();
  }

  void setMF() {
    MF = t2 - total3;
  }

  void setCapacidadPago(double x) {
    capacidadPago = x;
  }

  void setSolvencia(double x) {
    solvencia = x;
  }

  double getDesembolso1() => desembolso1;
  double getDesembolso2() => desembolso2;
  double getSolvencia() => solvencia;
  double getCapacidadPago() => capacidadPago;

  double getTVentas() => TVentas;
  double getTCostos() => TCostos;
  double getpoliza() => poliza;
  double getCuotaAprox() => cuotaAprox;

  double getMF() => MF;

  String getCuota() => cuota;

  double getFrecuencia() => frecuencia = 30;

  String getActividad() => actividad;

  double getAvion() => avion;

  double getRuta() => ruta;

  double getTG() => TG;

  double getMUB() => MUB;

  double getCostos() => costos;

  double getTotal1() => total1;

  double getTotal2() => total2;

  double getAPE() => APE;

  double getT1() => t1;

  double getT2() => t2;
  double getTotal3() => total3;

  double getEfec() {
    return total3;
  }

  double getTotalVentas() => totalVentas;

  void addList(key, List<List<String>> v) {
    mp[key] = v;
  }

  List<List<String>> getList(s) {
    return mp[s]!;
  }

  List<String> getAporteList() {
    List<String> ls = [];
    // mp.forEach((key, value) {
    //   double res = 0;
    //   value.forEach((element) {
    //     if(element.length > 4)
    //     res += double.tryParse(element[4])!;
    //    });
    //   ls.add(res.toStringAsFixed(2));
    //  });
    mp.forEach((key, value) {
      double res = 0;
      if (value.isNotEmpty)
        value[4].forEach((element) {
          if (element != '') {
            res += double.tryParse(element)!;
          }
        });
      ls.add(res.toStringAsFixed(2));
    });

    return ls;
  }

  List<String> getInvertidoList() {
    List<String> ls = [];
    // mp.forEach((key, value) {
    //   double res = 0;
    //   value[3].forEach((element) {
    //     if(element.length>5 )
    //     res += double.tryParse(element[5])!;
    //    });
    //   ls.add(res.toStringAsFixed(2));
    //  });

    mp.forEach((key, value) {
      double res = 0;
      if (value.isNotEmpty)
        value[5].forEach((element) {
          if (element != '') {
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

  double getTotalAporte() {
    double res = 0;
    mp.forEach((key, value) {
      if (value.isNotEmpty)
        value[3].forEach((element) {
          if (element != '') {
            res += double.tryParse(element)!;
          }
        });
    });

    return res;
  }

  double calc(List<String> ls, int index) {
    double res = 0;

    ls.forEach((element) {
      var grid = mp[element];

      if (grid!.isNotEmpty) {
        grid[index].forEach((element) {
          if (element != '') {
            res += double.tryParse(element)!;
          }
        });
      }
    });
    return res;
  }

  double getAporte1() {
    var values = ['a1', 'a', 'b', 'c'];
    return calc(values, 4);
  }

  double getInvertido1() {
    var values = ['a1', 'a', 'b', 'c'];
    return calc(values, 5);
  }

  double getAporte2() {
    var values = ['d', 'e', 'f', 'g'];
    return calc(values, 4);
  }

  double getInvertido2() {
    var values = ['d', 'e', 'f', 'g'];
    return calc(values, 5);
  }

  void setOtros(double parse) {
    otros = parse;
  }

  void setCajadeAhorro(double parse) {
    cajaDeAhorro = parse;
  }

  double getOtros() => otros;

  double getCajadeAhorro() => cajaDeAhorro;
}
