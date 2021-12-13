import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoadFactor extends StatefulWidget {
  LoadFactor({Key? key}) : super(key: key);

  @override
  _LoadFactorState createState() => _LoadFactorState();
}

class _LoadFactorState extends State<LoadFactor> {
  final a = TextEditingController();

  final b = TextEditingController();

  final c = TextEditingController();

  final d = TextEditingController();

  final e = TextEditingController();

  final rpk = TextEditingController();

  final ask = TextEditingController();

  final resp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Load Factor'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('Precio de Ticket')),
                  Container(
                      width: 150,
                      child: TextFormField(
                          controller: a,
                          onChanged: calc,
                          keyboardType: TextInputType.number))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('# de vuelos al dia')),
                  Container(
                      width: 150,
                      child: TextFormField(
                          controller: b,
                          onChanged: calc,
                          keyboardType: TextInputType.number))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('Modelo de Avión')),
                  Container(
                    width: 150,
                    child: Dropdown(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(child: Text('Ruta Específica')),
                  Container(
                    width: 300,
                    child: Dropdown2(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('RPK')),
                  Container(child: Text('ASK'))
                ],
              ),
              Consumer<Data>(builder: (context, data, widget) {
                double avi = data.getAvion();
                double rut = data.getRuta();
                double revenue = avi *
                    rut *
                    (double.tryParse(a.text) ?? 1) *
                    (double.tryParse(b.text) ?? 1);
                double avaiable = avi * rut * (double.tryParse(b.text) ?? 1);
                rpk.text = revenue.toString();
                ask.text = avaiable.toString();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextFormField(
                            controller: rpk, onChanged: calc, readOnly: true)),
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextFormField(
                            controller: ask, onChanged: calc, readOnly: true))
                  ],
                );
              }),
              Container(
                height: MediaQuery.of(context).size.width / 2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Text('LOAD FACTOR')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      // controller: resp,
                      child: TextFormField(controller: resp, readOnly: true))
                ],
              ),
            ],
          ),
        ));
  }

  void calc(s) {
    if (rpk.text.isNotEmpty && ask.text.isNotEmpty) {
      double res = double.parse(ask.text) / double.parse(rpk.text);
      setState(() {
        resp.text = res.toStringAsFixed(2);
      });
    }
  }
}

class Dropdown extends StatefulWidget {
  Dropdown({Key? key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class Dropdown2 extends StatefulWidget {
  Dropdown2({Key? key}) : super(key: key);

  @override
  _DropdownState2 createState() => _DropdownState2();
}

class _DropdownState extends State<Dropdown> {
  String value = 'AVRO-RJ85';
  final Map<String, double> map = {
    "AVRO-RJ85": 112,
    "AVRO-RJ100": 100,
  };
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ['AVRO-RJ85', 'AVRO-RJ100']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? newValue) {
        Provider.of<Data>(context, listen: false).setAvion(map[newValue]!);
        setState(() {
          value = newValue!;
        });
      },
      value: value,
    );
  }
}

class _DropdownState2 extends State<Dropdown2> {
  String value = '-';
  final Map<String, double> map = {
    "-": 0,
    "Cbba - La Paz": 240,
    "Cbba - Santa Cruz": 323.92,
    "Cbba - Potosi": 241,
    "Cbba - Pando": 761,
    "Cbba - Beni": 397,
    "Cbba - Chuquisaca": 199.11,
    "Santa Cruz - La Paz": 553,
    "Santa Cruz - Potosi": 562,
    "Santa Cruz - Tarija": 707,
    "Santa Cruz - Pando": 851,
    "Santa Cruz - Beni": 464,
    "Santa Cruz - Chuquisaca": 259.8,
    "Potosi - La Paz": 425.15,
    "Potosi - Pando": 985,
    "Potosi - Beni": 995,
    "Pando - La Paz": 600,
    "Pando - Beni": 448,
    "Pando - Chuquisaca": 1070,
    "Beni - La Paz": 436,
    "Beni - Chuquisaca": 516,
    "Chuquisaca - La Paz": 413.48,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        '-',
        'Cbba - La Paz',
        'Cbba - Santa Cruz',
        'Cbba - Potosi',
        'Cbba - Pando',
        'Cbba - Beni',
        'Cbba - Chuquisaca',
        'Santa Cruz - La Paz',
        'Santa Cruz - Potosi',
        'Santa Cruz - Tarija',
        'Santa Cruz - Pando',
        'Santa Cruz - Beni',
        'Santa Cruz - Chuquisaca',
        'Potosi - La Paz',
        'Potosi - Pando',
        'Potosi - Beni',
        'Pando - La Paz',
        'Pando - Beni',
        'Pando - Chuquisaca',
        'Beni - La Paz',
        'Beni - Chuquisaca',
        'Chuquisaca - La Paz',
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (String? newValue) {
        Provider.of<Data>(context, listen: false).setRuta(map[newValue]!);
        setState(() {
          value = newValue!;
        });
      },
      value: value,
    );
  }
}
