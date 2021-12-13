import 'package:app/Data.dart';
import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class FlujosNext extends StatefulWidget {
  FlujosNext({Key? key}) : super(key: key);

  @override
  _FlujosState createState() => _FlujosState();
}

class _FlujosState extends State<FlujosNext> {
  final controlers =
      List.generate(8, (i) => TextEditingController(text: '0.00'));

  void onChange(String d, int i) {
    double res = 0;
    controlers.forEach((e) {
      if (double.tryParse(e.text) != null) res += double.parse(e.text);
    });
    setState(() {
      sum.text = res.toStringAsFixed(2);
    });
  }

  final sum = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final TG = Provider.of<Data>(context, listen: false).getTG();
    final totalv = Provider.of<Data>(context, listen: false).getTotalVentas();
    final costos = Provider.of<Data>(context, listen: false).getCostos();
    final MUB = Provider.of<Data>(context, listen: false).getMUB();

    controlers[0].text = totalv.toStringAsFixed(2);
    controlers[1].text = costos.toStringAsFixed(2);
    controlers[2].text = MUB.toStringAsFixed(2);
    controlers[6].text = (TG * 12).toStringAsFixed(2);
    try {
      controlers[5].text =
          (double.parse(controlers[3].text) - double.parse(controlers[4].text))
              .toStringAsFixed(2);
      controlers[7].text =
          (double.parse(controlers[6].text) - double.parse(controlers[5].text))
              .toStringAsFixed(2);
    } catch (e) {
      controlers[5].text = "0.00";
      controlers[7].text = "0.00";
    }
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text("Flujos"),
            actions: [Icon(Icons.more_vert)]),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Margen Bruto'),
              Container(
                height: 200,
                child: GridView.count(
                  childAspectRatio: 8 / 2,
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  padding: EdgeInsets.all(23),
                  mainAxisSpacing: 15,
                  children: <Widget>[
                    Container(),
                    Center(
                      child: Text('Ventas'),
                    ),
                    Center(
                      child: Text('Costos'),
                    ),
                    Center(
                      child: Text('Margen'),
                    ),
                    Center(
                      child: Text('MAnufactura/\nServicios'),
                    ),
                    TextFormField(
                        controller: controlers[0],
                        onChanged: (s) {
                          onChange(s, 14);
                        }),
                    TextFormField(
                        controller: controlers[1],
                        onChanged: (s) {
                          onChange(s, 15);
                        }),
                    TextFormField(controller: controlers[2]),
                  ],
                ),
              ),
              Text('Tabla de utilidad'),
              Container(
                height: 400,
                child: GridView.count(
                  childAspectRatio: 8 / 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  padding: EdgeInsets.all(23),
                  mainAxisSpacing: 15,
                  children: <Widget>[
                    Center(
                      child: Text('(+) Ingresos Totales '),
                    ),
                    TextFormField(
                      controller: controlers[3],
                      onChanged: (s) {
                        setState(() {
                          try {
                            controlers[5].text =
                                (double.parse(controlers[3].text) -
                                        double.parse(controlers[4].text))
                                    .toStringAsFixed(2);
                            controlers[7].text =
                                (double.parse(controlers[6].text) -
                                        double.parse(controlers[5].text))
                                    .toStringAsFixed(2);
                          } catch (e) {}
                        });
                      },
                    ),
                    Center(
                      child: Text('(-) Costos Directos'),
                    ),
                    TextFormField(
                      controller: controlers[1],
                    ),
                    Center(child: Text('(=) Utilidad Bruta')),
                    TextFormField(controller: controlers[5]),
                    Center(
                      child: Text('(-) Costo Operativo'),
                    ),
                    TextFormField(controller: controlers[6]),
                    Center(
                      child: Text('(=) Utilidad Operatva'),
                    ),
                    TextFormField(
                      controller: controlers[7],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Flujos3');
                },
                child: Text('Siguente'),
              )
            ]));
  }
}
