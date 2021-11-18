import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Calc extends StatelessWidget {
  Calc({Key? key}) : super(key: key);

  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  final d = TextEditingController();

 @override
  Widget build(BuildContext context) {
    a.text = Provider.of<Data>(context, listen: false).getTotal1().toStringAsFixed(2);
    b.text = Provider.of<Data>(context, listen: false).getTotal2().toStringAsFixed(2);
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Presupuesto de emprendimiento'),
          actions: [Icon(Icons.more_vert)]),
        body:Container(
      padding: EdgeInsets.all(50),
      child: Column(
      
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['a','Materia Prima/Insumos']);}, child: Text('Materia Prima/Insumos')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['b','Requerimientos Promocionales']);}, child: Text('Requerimientos Promocionales')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['c','Gastos Operativos']);}, child: Text('Gastos Operativos')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['e','Infraestructura/Terrenos']);}, child: Text('Infraestructura/Terrenos')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['f','Maquinaria/Equipos']);}, child: Text('Maquinaria/Equipos')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Table',arguments: ['g','Requerimientos Legales']);}, child: Text('Requerimientos Legales')),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text('Aporte propio') , Container( width:200 , child :TextFormField(controller: a,))],),
          Row(mainAxisAlignment:  MainAxisAlignment.spaceAround, children: [Text('Total') , Container( width:200 , child :TextFormField(controller: b,))],)
        ],
      ),
    ));
  }
}

