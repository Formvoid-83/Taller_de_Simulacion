import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: EdgeInsets.all(50),
      child: Column(
      
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Aerolínea    Elysium' , style: TextStyle(fontSize: 23, fontFamily: 'Comic Sans')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'presEmp');}, child: Text('Presupuesto de emprendimiento')),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'Calc');}, child: Text('Presupuesto total')),
          ElevatedButton(onPressed: (){}, child: Text('Costos')),
          ElevatedButton(onPressed: (){}, child: Text('Flujo')),
          ElevatedButton(onPressed: (){}, child: Text('Load factor')),
        ],
      ),
    );
  }
}