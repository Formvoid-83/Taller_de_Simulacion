import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body:  Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('lib/logo.jpeg'),
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'presEmp');}, child: Text('Presupuesto de emprendimiento')),
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'PrespTotal',arguments: ['', 'Presupuesto total']);}, child: Text('Presupuesto total')),
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'costos',arguments: ['', 'Costos']);}, child: Text('Costos')),
            ElevatedButton(onPressed: (){}, child: Text('Flujo')),
            ElevatedButton(onPressed: (){}, child: Text('Load factor')),
          ],
        ),
      ),
    );
  }
}