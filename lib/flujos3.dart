import 'package:app/asxs.dart';
import 'package:app/costossig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Data.dart';

class Flujos3 extends StatefulWidget {
  Flujos3({Key? key}) : super(key: key);

  @override
  _FlujosState createState() => _FlujosState();
}

class _FlujosState extends State<Flujos3> {
  final a = TextEditingController(text: '');
  final b = TextEditingController(text: '');
  final c = TextEditingController(text: '');
  final d = TextEditingController(text: '');
  final e = TextEditingController(text: '');
  final p = TextEditingController(text: '');
  double tasaInteres = 0.0,
      frecuencia = 0,
      poliza = 0,
      plazo = 0,
      amortizacion = 0,
      periodo = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final double monto = Provider.of<Data>(context, listen: false).getMF();

    e.text = monto.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text("Flujos "),
          actions: [Icon(Icons.more_vert)]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(13),
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Frecuencia'),
                    DropdownF(),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Poliza'),
                    Container(
                        width: 150,
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "Ingrese valores "),
                          controller: a,
                          onChanged: (s) {
                            poliza = double.tryParse(s) ?? 0;
                            Provider.of<Data>(context, listen: false)
                                .setpoliza(poliza);
                          },
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Periodo de gracia      '),
                    Container(
                        width: 150,
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "Ingrese valores "),
                          controller: p,
                          onChanged: (s) {
                            periodo = double.tryParse(s) ?? 1;
                          },
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Tasa de interés         '),
                    Container(
                        width: 150,
                        child: Consumer<Data>(
                          builder: (
                            context,
                            data,
                            child,
                          ) {
                            print("aasd ${data.getActividad()}");

                            if (data.getActividad() == 'Productiva') {
                              d.text = '0.07';
                              tasaInteres = 0.07;
                            } else {
                              tasaInteres = 0.115;

                              d.text = '0.115';
                            }
                            return TextFormField(controller: d, readOnly: true);
                          },
                        )),
                  ],
                ),
                Text("Datos de credito"),
                Container(
                  height: 300,
                  child: GridView.count(
                    childAspectRatio: 8 / 2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    padding: EdgeInsets.all(23),
                    mainAxisSpacing: 15,
                    children: <Widget>[
                      Text('Monto'),
                      TextFormField(
                        controller: e,
                        readOnly: true,
                      ),
                      Text('Actividad'),
                      DropdownA(),
                      Text('Tipo de Cuota'),
                      DropdownC(),
                      Text('Plazo Meses'),
                      TextFormField(
                          decoration:
                              InputDecoration(hintText: "Ingese valores "),
                          controller: b,
                          onChanged: (s) {
                            double plazo = double.tryParse(s) ?? 0;

                            if (plazo > 84) {
                              b.text = '';
                              final snackBar = SnackBar(
                                content: const Text(
                                    'El plazo máximo es de 84 meses'),
                                action: SnackBarAction(
                                  label: 'Entendido',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('CUOTA APROXIMADA         '),
                    Consumer<Data>(builder: (context, data, widget) {
                      if ((1 > 360 / data.getFrecuencia() * ((periodo) / 12)) &&
                          (360 / data.getFrecuencia()) * (plazo / 12) >= 1) {
                        amortizacion = monto /
                            ((360 / data.getFrecuencia()) *
                                ((plazo / 12) - periodo / 2));
                      } else {
                        amortizacion = 0;
                      }

                      double interes =
                          tasaInteres * monto / (360 / data.getFrecuencia());
                      double cuota = amortizacion + interes;
                      if (data.getCuota() == 'Variable')
                        c.text = cuota.toStringAsFixed(2);
                      else
                        c.text = 'Ingrese datos';
                      print([
                        data.getFrecuencia(),
                        periodo,
                        plazo,
                        tasaInteres,
                        amortizacion,
                        interes,
                        cuota,
                        monto
                      ]);
                      return Container(
                        width: 200,
                        child: TextFormField(
                          // decoration:  (va) ? InputDecoration(hintText: "Ingese valores "):null ,

                          controller: c,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                  onPressed: () {
                    //   if ((1 > 360 / data.getFrecuencia() * ((periodo) / 12)) &&
                    //       (360 / data.getFrecuencia()) * (plazo / 12) >= 1) {
                    //     amortizacion = monto /
                    //         ((360 / data.getFrecuencia()) *
                    //             ((plazo / 12) - periodo / 2));
                    //   } else {
                    //     amortizacion = 0;
                    //   }

                    //   double interes = tasaInteres * monto / (360 / frecuencia);
                    //   double cuota = amortizacion + interes;
                    //   if (data.getCuota() == 'Variable')
                    //     c.text = cuota.toStringAsFixed(2);
                    //   else
                    //     c.text = 'Ingrese datos';

                    setState(() {});
                  },
                  child: Text('Calcular'),
                )
              ]),
        ),
      ),
    );
  }
}
/*
Frecuencia: MENSUAL       30
	    BIMENSUAL 	  60
	    TRIMESTRAL 	  90
	    CUATRIMESTRAL 120
	    SEMESTRAL 	  180
	    ANUAL	  360
TASA DE INTERÉS = 	0.07 SI ACTIVIDAD = Productiva
			0.115 SI ACTIVIDAD = Servicios

CUOTA APROX = AMORTIZACIÓN + INTERÉS

AMORTIZACION=
	SI{
		1>(360/FRECUENCIA) * (1/2)
				Y
		(360/FRECUENCIA)*(PLAZO/12) >= 1
	ENTONCES
		MONTO/((360/FRECUENCIA)*((PLAZO/12)-1/2))
	ELSE
		0

INTERES=
	TASA INTERÉS * MONTO / (360/FRECUENCIA)
*/

class DropdownA extends StatefulWidget {
  DropdownA({Key? key}) : super(key: key);

  @override
  _DropdownStateA createState() => _DropdownStateA();
}

class _DropdownStateA extends State<DropdownA> {
  String value = 'Productiva';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ['Productiva', 'Servicios']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? newValue) {
        Provider.of<Data>(context, listen: false).setActividad(newValue!);
        setState(() {
          value = newValue;
        });
      },
      value: value,
    );
  }
}

class DropdownF extends StatefulWidget {
  DropdownF({Key? key}) : super(key: key);

  @override
  _DropdownStateF createState() => _DropdownStateF();
}

class _DropdownStateF extends State<DropdownF> {
  String value = 'MENSUAL';

  Map<String, double> mp = {
    'MENSUAL': 30,
    'BIMENSUAL': 60,
    'TRIMESTRAL': 90,
    'CUATRIMESTRAL': 120,
    'SEMESTRAL': 180,
    'ANUAL': 360,
  };
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        'MENSUAL',
        'BIMENSUAL',
        'TRIMESTRAL',
        'CUATRIMESTRAL',
        'SEMESTRAL',
        'ANUAL',
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (String? newValue) {
        Provider.of<Data>(context, listen: false).setFrecuencia(mp[newValue]!);
        setState(() {
          value = newValue!;
        });
      },
      value: value,
    );
  }
}

class DropdownC extends StatefulWidget {
  DropdownC({Key? key}) : super(key: key);

  @override
  _DropdownStateC createState() => _DropdownStateC();
}

class _DropdownStateC extends State<DropdownC> {
  String value = 'Variable';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ['Variable', 'Personalizable']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? newValue) {
        Provider.of<Data>(context, listen: false).setCuota(newValue!);

        setState(() {
          value = newValue;
        });
      },
      value: value,
    );
  }
}
