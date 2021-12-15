import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Resultados2 extends StatefulWidget {
  Resultados2({Key? key}) : super(key: key);

  @override
  _Resultados2State createState() => _Resultados2State();
}

class _Resultados2State extends State<Resultados2> {
  final mf = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  final d = TextEditingController();

/*

SOLVENCIA = 
[(TOTAL ACTIVO NEGOCIO + TOTAL ACTIVO DE LA FAMILIA) - 
(TOTAL PASIVO DEL NEGOCIO + TOTAL PASIVO DE LA FAMILIA)] 
/ MONTO CRÉDITO (EL MF)
*/


  @override
  Widget build(BuildContext context) {

   double capacidadPago =   Provider.of<Data>(context, listen:false).getCapacidadPago();
   double solvencia =   Provider.of<Data>(context, listen:false).getSolvencia();
  

    double prespTotal, capOperativo, capInversion, totRequerido, MC, valActivos;
    prespTotal = Provider.of<Data>(context, listen: false).getTotal3();
    capOperativo = Provider.of<Data>(context, listen: false).getInvertido1();
    capInversion = Provider.of<Data>(context, listen: false).getInvertido2();
    totRequerido = capInversion + capOperativo;
    MC = Provider.of<Data>(context, listen: false).getMF();
    valActivos = Provider.of<Data>(context, listen: false).getTVentas() -
        Provider.of<Data>(context, listen: false).getTCostos();

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Idicadores Finales'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 2.5,
            padding: EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               
                const SizedBox(
                  height: 50,
                ),
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
                          child: Center(child: Text('Datos plan de Negocio')),
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(child: Text('')),
                        )
                      ]),
                      TableRow(children: [
                        Container(
                          width: 200,
                          height: 30,
                          child: Center(
                              child: Text(
                                  'EFECTIVO PARA REALIZAR \nEMPRENDIMIENTO')),
                        ),
                        Container(
                          width: 200,
                          height: 55,
                          child: Center(
                              child: Text(prespTotal.toStringAsFixed(2))),
                        )
                      ])
                    ]),
                const SizedBox(height: 50),
               
                Consumer<Data>(builder: (context, data, widget) {
                  double monto = data.getMF();
                  double ventas = data.getTVentas();
                  double costos = data.getTCostos();
                  //double algo = Provider.of<Data>(context , listen: false).get();
                  mf.text = monto.toString();

                  return Container(
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
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(
                                    child: Text('Datos plan de Negocio')),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(child: Text('')),
                              ),
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(
                                    child: Text(
                                        'REQUERIMIENTO CAPITAL \nOPERATIVO')),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(
                                    child:
                                        Text(capOperativo.toStringAsFixed(2))),
                              ),
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(
                                    child: Text(
                                        'REQUERIMIENTO CAPITAL\nINVERSION')),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Center(
                                    child:
                                        Text(capOperativo.toStringAsFixed(2))),
                              ),
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Column(
                                  children: [
                                    Text('TOTAL REQUERIDO'),
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 200,
                                height: 55,
                                child: Column(
                                  children: [
                                    Text(totRequerido.toStringAsFixed(2)),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ]),
                  );
                }),
                const SizedBox(height: 50),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  width: MediaQuery.of(context).size.width - 10,
                  child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 55,
                            child: Center(
                                child: Text(
                                    'INDICADORES FINANCIEROS \nDE DECISION ')),
                          ),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                width: 100,
                                height: 75,
                                child: Center(child: Text('RATIO')),
                              )),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              width: 100,
                              height: 75,
                              child: Center(child: Text('Parámetro')),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              width: 100,
                              height: 75,
                              child: Center(child: Text('Cumplimiento')),
                            ),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text(
                                    'Aporte del 15% de Efectivo\nen plan de negocios')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text((((prespTotal / totRequerido).isNaN)?0:(prespTotal / totRequerido) )
                                    .toStringAsFixed(2))),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('>= 15%')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text((prespTotal / totRequerido > 0)
                                    ? 'Cumple'
                                    : 'NO Cumple')),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('Requerimiento * 85%')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text((((totRequerido * 85 / MC).isNaN)?0:(totRequerido * 85 / MC)
                            ).toStringAsFixed(2))),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text(' = 1.0')),
                          ),
                          Container(
                              width: 100,
                              height: 75,
                              child: Center(
                                child: Text(((totRequerido * 85 / MC) == 1.0)
                                    ? 'Cumple'
                                    : 'No cumple'),
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text('De cobertura de garantía ')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child:
                                    Text((((MC / valActivos).isNaN)?0:(MC / valActivos) ).toStringAsFixed(2))),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text(' >= 0.60')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text((MC / valActivos >= 0.60)
                                    ? 'Cumple'
                                    : 'NO Cumple')),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('De Solvencia')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text(((solvencia.isNaN)?0:solvencia).toStringAsFixed(2))),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('>= 0.60')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text(( solvencia >= 0.60)
                                    ? 'Cumple'
                                    : 'NO Cumple')),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('De capacidad de Pago')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text(((capacidadPago.isNaN)?0:capacidadPago).toStringAsFixed(2))),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(child: Text('>= 1.0')),
                          ),
                          Container(
                            width: 100,
                            height: 75,
                            child: Center(
                                child: Text((capacidadPago >= 1.0)
                                    ? 'Cumple'
                                    : 'NO Cumple')),
                          ),
                        ]),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

 

//   void calcSolvencia()
//   {
//     = ((p(g.text,0) + p(h.text,0)) - 
// ( p(g.text,0) + p(k.text,0))) 
// / mff  ; 
//   }
}
