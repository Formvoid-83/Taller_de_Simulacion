import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TableView extends StatefulWidget {
  TableView({Key? key}) : super(key: key);

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  final a = TextEditingController();

  final b = TextEditingController();

  final c = TextEditingController();

  final d = TextEditingController();

  final e = TextEditingController();

  final f = TextEditingController();

  final g = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Object>? param = ModalRoute.of(context)!.settings.arguments as List<Object>?;
    final Object? key = param![0];
    final String title = param[1] as String;
    final list = Provider.of<Data>(context).getList(key);
    Text info = Text('');

    void calc(){
      double res = 0;
       list.forEach((element) {
        res += element['Aporte Propio']!;
      });
      a.text = '$res';
      res = 0;
      list.forEach((element) {
        res += element['Invertido']!;
      });
      b.text = '$res';
      setState(() {});
    }


    void add() {
      var map = {
        'Detalle': c.text,
        'Unidad': d.text,
        'Cantidad': double.parse(e.text),
        'Precio': double.parse(f.text),
        'Aporte Propio': double.parse(g.text),
        'Invertido': double.parse(e.text)* double.parse(f.text),
      };
      Provider.of<Data>(context, listen: false).addList(key, list);
      list.add(map);
      calc();
      if(Provider.of<Data>(context, listen: false).exceed()){
        final snackBar = SnackBar(content: Text("Este campo no debería exceder (el aporte propio o el total)"));
        list.removeLast();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
        
    }

    calc();
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Detalle')),
                      DataColumn(label: Text('Unidad')),
                      DataColumn(label: Text('Cantidad')),
                      DataColumn(label: Text('Precio')),
                      DataColumn(label: Text('Aporte Propio')),
                      DataColumn(label: Text('Invertido')),
                    ],
                    rows: list
                        .map((e) => DataRow(
                            cells: e.values
                                .map((value) => DataCell(Text('$value')))
                                .toList()))
                        .toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  info,
                  Text('Sub-total:    '),
                  Container(
                      width: 100,
                    margin:EdgeInsets.all(7),

                      child: TextFormField(
                        controller: a,
                      )),
                  Container(
                    width: 100,
                    margin:EdgeInsets.all(7),

                    child: TextFormField(controller: b),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin:EdgeInsets.all(7),
                    width: 100,
                    child: TextFormField(controller: c),
                  ),
                  Container(
                    width: 100,
                    margin:EdgeInsets.all(7),

                    child: TextFormField(controller: d),
                  ),
                  Container(
                    width: 100,
                    margin:EdgeInsets.all(7),
                    
                    child: TextFormField(controller: e),
                  ),
                  Container(
                    width: 100,
                    margin:EdgeInsets.all(7),
                    child: TextFormField(controller: f),
                  ),
                  Container(
                    width: 100,
                    margin:EdgeInsets.all(7),
                    child: TextFormField(controller: g ,),
                  ),
                ],
              ),
              Container(height: 50,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
