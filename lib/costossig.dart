import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'asxs.dart';

class CostosSig extends StatefulWidget {
  CostosSig({Key? key}) : super(key: key);

  @override
  _CostosState createState() => _CostosState();
}

class _CostosState extends State<CostosSig> {
  final titleRow = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
    'Anual'
  ];
  final titleColumn = ['Ventas\nMensuales', 'Costos Produccion\nMensual'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<String>? param =
        ModalRoute.of(context)!.settings.arguments as List<String>?;
    final String key = param![0];
    final String title = param[1];

    String value = '-';

    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Rango de ventas en Bs.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Alta  '),
                Container(
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Media'),
                Container(
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Baja  '),
                Container(
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            Expanded(
                child: StickyHeadersTable(
              columnsLength: titleColumn.length,
              rowsLength: titleRow.length,
              columnsTitleBuilder: (i) => TableCel.stickyRow(
                titleColumn[i],
                cellDimensions:
                    CellDimensions.uniform(width: 300, height: double.infinity),
                textStyle: textTheme.button!.copyWith(fontSize: 15.0),
              ),
              rowsTitleBuilder: (i) => TableCel.stickyRow(
                titleRow[i],
                cellDimensions:
                    CellDimensions.uniform(width: 200, height: double.infinity),
              ),
              contentCellBuilder: (i, j) => (i == 0)
                  ? TableCelWidget.content(Dropdown())
                  : TableCel.content(
                      '',
                      cellDimensions: CellDimensions.uniform(
                          width: 300, height: double.infinity),
                    ),
              // TableCell.content(
              //   data[i][j],
              //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              // ),
              legendCell: TableCel.legend(
                'Mes',
                textStyle: textTheme.button!.copyWith(fontSize: 16.5),
              ),
            )),
          ]),
    );
  }
}

class Dropdown extends StatefulWidget {
  Dropdown({Key? key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String value = '-';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ['-', 'A', 'M', 'B']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          value = newValue!;
        });
      },
      value: value,
    );
  }
}
