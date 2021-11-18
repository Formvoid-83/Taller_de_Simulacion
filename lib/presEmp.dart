import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PresEmp extends StatelessWidget {
  PresEmp({Key? key}) : super(key: key);
 
  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  final d = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Presupuesto de emprendimiento'),
        ),
        body: Container(
          padding: EdgeInsets.all(17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('Efectivo/Origen')),
                  Container(
                      width: 150,child: TextFormField( controller: a, onChanged:calc,keyboardType: TextInputType.number))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('Caja de ahorro/\nEntidad financiera')),
                  Container(
                      width: 150,child: TextFormField(controller: b  ,  onChanged:calc , keyboardType: TextInputType.number))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('Otros')),
                  Container(
                      width: 150,child: TextFormField( controller: c , onChanged:calc , keyboardType: TextInputType.number,))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 150,
                      child: TextFormField(
                        controller: d,
                        readOnly: true ,
                        
                        // initialValue: 'Output',
                      ))
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(onPressed:() => contin(context), child: Text('Continuar'))
              ]),
            ],
          ),
        ));
  }
  void contin(BuildContext context){
     Provider.of<Data>(context , listen: false).setTotal2(double.parse(d.text));
     Provider.of<Data>(context , listen: false).setTotal1(double.parse(a.text));
    print(Provider.of<Data>(context, listen: false).total1); 
    print(Provider.of<Data>(context, listen: false).total2); 
    Navigator.pushNamed(context,'Calc' );
  }

  void calc (s){
    if(a.text.isNotEmpty && b.text.isNotEmpty && c.text.isNotEmpty){
    double res = double.parse(a.text) + double.parse(b.text) +double.parse(c.text); 
    d.text = res.toStringAsFixed(2);
    
    }
  }  
      
  
}
