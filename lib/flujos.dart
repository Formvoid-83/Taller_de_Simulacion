import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'Data.dart';

class Flujos extends StatefulWidget {
  Flujos({Key? key}) : super(key: key);

  @override
  _FlujosState createState() => _FlujosState();
}

class _FlujosState extends State<Flujos> {
  final titleColumn = ['Negocio'];

  final titleRow2 = ['', '', ''];

  final titleRow = [
    'Impuestos',
    'Alimentación',
    'Servicio Luz',
    'Servicio Agua',
    'Servicio Gas',
    'Teléfono',
    'Internet',
    'Alquiler',
    'Transporte',
    'Escritorio',
    'Empleados',
    'Promoción',
    'Impuestos',
  ];

  final controlers = List.generate(21, (i) => TextEditingController(text: ''));

  void onChange(String d, int i) {
    // controlers[i].text = d;
    double res = 0;
    controlers.forEach((e) {
      if (double.tryParse(e.text) != null) res += double.parse(e.text);
    });
    setState(() {
      sum.text = res.toStringAsFixed(2);
    });
  }
    double _scrollOffsetX = 0.0;
    double _scrollOffsetY = 0.0;
    final scroll = ScrollControllers(
      horizontalBodyController: ScrollController(), 
      verticalBodyController:  ScrollController(), 
      horizontalTitleController: ScrollController(), 
      verticalTitleController: ScrollController(), 
      
      );

  final sum = TextEditingController(text: '0.00');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<String>? param =
        ModalRoute.of(context)!.settings.arguments as List<String>?;
    final String key = param![0];
    final String title = param[1];
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + 300,
          child: Column(children: [
            Expanded(
              flex: 1,
              child: StickyHeadersTable(
                scrollControllers: scroll ,
                // initialScrollOffsetX: _scrollOffsetX,
                // initialScrollOffsetY: _scrollOffsetY,
                // onEndScrolling: (scrollOffsetX, scrollOffsetY) {
                //   _scrollOffsetX = scrollOffsetX;
                //   _scrollOffsetY = scrollOffsetY;
                // },
                columnsLength: titleColumn.length,
                rowsLength: titleRow.length,
                columnsTitleBuilder: (i) => TableCel.stickyRow(
                  titleColumn[i],
                  textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                ),
                rowsTitleBuilder: (i) => TableCel.content(
                  titleRow[i],
                  cellDimensions: CellDimensions.uniform(
                      width: 200, height: double.infinity),
                ),
                contentCellBuilder: (i, j) => TableCelWidget.content(TextField(
                  controller: controlers[j],
                  onChanged: (s) {
                    onChange(s, j);
                  },
                )),
                // TableCell.content(
                //   data[i][j],
                //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                // ),
                legendCell: TableCel.legend(
                  'Costos Operativos',
                  textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                ),
              ),
            ),
            SizedBox(
              height: 23,
            ),
            Text('Mantenimiento'),
            Container(
              height: 200,
              child: GridView.count(
                childAspectRatio: 8 / 2,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                padding: EdgeInsets.all(23),
                mainAxisSpacing: 15,
                children: <Widget>[
                  TextFormField(
                      controller: controlers[13],
                      onChanged: (s) {
                        onChange(s, 13);
                      }),
                  TextFormField(
                      controller: controlers[14],
                      onChanged: (s) {
                        onChange(s, 14);
                      }),
                  TextFormField(
                      controller: controlers[15],
                      onChanged: (s) {
                        onChange(s, 15);
                      }),
                  TextFormField(
                      controller: controlers[16],
                      onChanged: (s) {
                        onChange(s, 16);
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Text('Otros Imprevitos'),
            Container(
              height: 200,
              child: GridView.count(
                childAspectRatio: 8 / 2,
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                padding: EdgeInsets.all(23),
                mainAxisSpacing: 15,
                children: <Widget>[
                  TextFormField(
                    controller: controlers[17],
                    onChanged: (s) {
                      onChange(s, 17);
                    },
                  ),
                  TextFormField(
                      controller: controlers[18],
                      onChanged: (s) {
                        onChange(s, 18);
                      }),
                  Center(child: Text('TOTAL')),
                  TextFormField(
                      controller: controlers[19],
                      onChanged: (s) {
                        onChange(s, 19);
                      }),
                  TextFormField(
                      controller: controlers[20],
                      onChanged: (s) {
                        onChange(s, 20);
                      }),
                  TextFormField(
                    controller: sum,
                    readOnly: true,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 0,
            // ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Data>(context, listen: false)
                    .setTG(double.parse(sum.text));
                Navigator.pushNamed(context, 'FlujosNext');
              },
              child: Text('Siguente'),
            )
          ]),
        ),
      ),
    );
  }
}
