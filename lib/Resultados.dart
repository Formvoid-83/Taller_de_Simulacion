import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// typedef Type Name(params);

class Resultados extends StatelessWidget {
  Resultados({Key? key}) : super(key: key);

  final monf = TextEditingController();
  final cuo_t = TextEditingController();
  final act = TextEditingController();
  final cont = TextEditingController();
  final mc = TextEditingController();
  final ap = TextEditingController();
  final ven = TextEditingController();
  final cos = TextEditingController();
  final gas = TextEditingController();
  final gasf = TextEditingController();
  final ot  = TextEditingController();

  final e = TextEditingController();
  final f = TextEditingController();
  final g = TextEditingController();
  final h = TextEditingController();
  final i = TextEditingController();
  final j = TextEditingController();
  final k = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mf = Provider.of<Data>(context, listen: false).getMF();
    monf.text = mf.toString();

    double cuota = Provider.of<Data>(context, listen: false).getCuotaAprox();
    double polizaflu = Provider.of<Data>(context, listen: false).getpoliza();
    double frecuencia =
        Provider.of<Data>(context, listen: false).getFrecuencia();
    double ventas = Provider.of<Data>(context, listen: false).getTVentas();
    double costos = Provider.of<Data>(context, listen: false).getTCostos();

    double poliza = ((polizaflu / 1000) * 12) * mf * ((frecuencia) / 30) / 12;

    double cuot_Total = cuota + poliza;
    cuo_t.text = cuot_Total.toString();
    double activo = ventas - costos;
    act.text = activo.toString();

    double aportetot = Provider.of<Data>(context, listen: false).getAporte1() +
        Provider.of<Data>(context, listen: false).getAporte2();
    ap.text = aportetot.toString();
    ven.text = ventas.toString();
    cos.text = costos.toString();
    double gasto = Provider.of<Data>(context, listen: false).getTG();
    gas.text = gasto.toString();

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Indicadores Finales'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 2,
            padding: EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  child: Center(
                      child: Text('Datos del Resultado de Plan de Negocios')),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  width: MediaQuery.of(context).size.width - 10,
                  child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('Resultados')),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              width: 100,
                              height: 50,
                              child: Center(child: Text('')),
                            ),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                              width: 100,
                              height: 50,
                              child: Center(child: Text('MONTO CRÉDITO (Bs)'))),
                          Container(
                            width: 100,
                            height: 50,
                            child:
                                TextFormField(controller: monf, readOnly: true),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('CUOTA CREDITO')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: TextFormField(
                                controller: cuo_t, readOnly: true),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text('VALOR ACTIVOS'),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child:
                                TextFormField(controller: act, readOnly: true),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('T.C. CONTABLE')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: TextFormField(
                                controller: cont,
                                onChanged: calc,
                                keyboardType: TextInputType.number),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('MONTO CRÉDITO (\$)')),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              child: Center(
                                child: TextFormField(
                                    controller: mc, readOnly: true),
                              )),
                        ]),
                      ]),
                ),

                const SizedBox(height: 70),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        Container(
                          width: 200,
                          height: 55,
                          child: Center(child: Text('BALANCE GENERAL')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('DATOS')),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('TOTAL INVENTARIO')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: e,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('ACTIVO CORRIENTE')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: f,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('TOTAL ACTIVO DE NEGOCIO')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: g,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child:
                              Center(child: Text('TOTAL ACTIVO DE FAMILIA ')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: h,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('PASIVO CORRIENTE ')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: i,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child:
                              Center(child: Text('TOTAL PASIVO DEL NEGOCIO')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: TextFormField(
                            controller: j,
                            onChanged: (s) {
                              calcc();
                            },
                          )),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child:
                              Center(child: Text('TOTAL PASIVO DE LA FAMILIA')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: TextFormField(controller: k)),
                        )
                      ]),
                    ]),
           
                const SizedBox(height: 50),
                Container(
                    height: 100,
                    child: Center(child: Text('No. de Estados de Resultado'))),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  width: MediaQuery.of(context).size.width - 10,
                  child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('No')),
                          ),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 100,
                                height: 50,
                                child:
                                    Center(child: Text('Estado de Resultados')),
                              )),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              width: 100,
                              height: 50,
                              child: Center(child: Text('DATOS')),
                            ),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('0')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('APORTE PROPIO')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: TextFormField(
                                    controller: ap, readOnly: true)),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('1')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('VENTAS')),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              child: Center(
                                  child: Center(
                                child: TextFormField(
                                    controller: ven, readOnly: true),
                              ))),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('2')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('COSTOS PRODUCCION')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: TextFormField(
                                    controller: cos, readOnly: true)),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('3')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('GASTO OPERATIVO')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: TextFormField(
                                    controller: gas, readOnly: true)),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('4')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('GASTO FAMILIAR')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: TextFormField(
                                    controller: gasf,
                                    onChanged: calc,
                                    keyboardType: TextInputType.number)),
                          )
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('5')),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('OTROS INGRESOS')),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              child: Center(
                                  child: TextFormField(
                                      controller: ot,
                                      onChanged: calc,
                                      keyboardType: TextInputType.number)))
                        ]),
                      ]),
                ),
                SizedBox(height: 50,),
                    Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {

                          double  aux = 

(( double.tryParse(ven.text) ??0   )-
( double.tryParse(cos.text) ??0   )-
( double.tryParse(gas.text) ??0   )-
( double.tryParse(gasf.text) ??0   )+
( double.tryParse(ot.text) ??0   )) * 0.85 /   
(double.tryParse(cuo_t.text)??1 );


  
double solvencia = 

((p(g.text,0) + p(h.text,0)) - 
( p(g.text,0) + p(k.text,0))) 
/ mf  ; 

                          Provider.of<Data>(context, listen: false).setSolvencia(solvencia); 
                          Provider.of<Data>(context, listen: false).setCapacidadPago(aux); 
                          Navigator.pushNamed(context, 'Resultados2');
                        },
                        child: Text('Siguiente')),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  
double p(String s , double i  )=>
  (double.tryParse(s) ??i);

  void calc(s) {
    if (cont.text.isNotEmpty && monf.text.isNotEmpty) {
      double res = double.parse(monf.text) / double.parse(cont.text);
      mc.text = res.toStringAsFixed(2);
    }
  }

   void calcc() {
    // setState(() {
    k.text = ((double.tryParse(e.text) ?? 0) +
            (double.tryParse(f.text) ?? 0) +
            (double.tryParse(g.text) ?? 0) +
            (double.tryParse(h.text) ?? 0) +
            (double.tryParse(i.text) ?? 0) +
            (double.tryParse(j.text) ?? 0))
        .toStringAsFixed(2);
    // });
  }

}
