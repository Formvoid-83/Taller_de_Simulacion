import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Calc extends StatefulWidget {
  Calc({Key? key}) : super(key: key);

  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  final a = TextEditingController();

  final b = TextEditingController();

  final c = TextEditingController();

  final d = TextEditingController();

  @override
  Widget build(BuildContext context) {
    a.text = Provider.of<Data>(context, listen: false)
        .getAporte1()
        .toStringAsFixed(2);
    b.text = Provider.of<Data>(context, listen: false)
        .getInvertido1()
        .toStringAsFixed(2);
    c.text = Provider.of<Data>(context, listen: false)
        .getAporte2()
        .toStringAsFixed(2);
    d.text = Provider.of<Data>(context, listen: false)
        .getInvertido2()
        .toStringAsFixed(2);

    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Presupuesto de emprendimiento'),
            actions: [Icon(Icons.more_vert)]),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Capital Operativo',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aporte propio'),
                    Container(
                        width: 150,
                        child: TextFormField(
                          controller: a,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Invertido'),
                    Container(
                        width: 150,
                        child: TextFormField(
                          controller: b,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Obra',
                              arguments: ['a1', 'Mano de Obra del Emprendedor'])
                          .then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Mano de Obra de Emprendedor')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                          arguments: ['a', 'Materia Prima/Insumos']).then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Materia Prima/Insumos')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                              arguments: ['b', 'Requerimientos Promocionales'])
                          .then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Requerimientos Promocionales')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                          arguments: ['c', 'Gastos Operativos']).then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Gastos Operativos')),
                Text('Capital de Inversión',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aporte propio'),
                    Container(
                        width: 150,
                        child: TextFormField(
                          controller: c,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Invertido'),
                    Container(
                        width: 150,
                        child: TextFormField(
                          controller: d,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                              arguments: ['d', 'Infraestructura/Terrenos'])
                          .then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Infraestructura/Terrenos')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                          arguments: ['e', 'Requerimientos Legales']).then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Requerimientos Legales')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Table',
                          arguments: ['f', 'Maquinaria/Equipos']).then((_) {
                        setState(() {});
                      });
                    },
                    child: Text('Maquinaria/Equipos')),
              ],
            ),
          ),
        ));
  }
}
