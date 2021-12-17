import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'Data.dart';

class Costos extends StatefulWidget {
  Costos({Key? key}) : super(key: key);

  @override
  _CostosState createState() => _CostosState();
}

class _CostosState extends State<Costos> {
  // final tablecontent = TableContent();

  final titleRow = List.generate(10, (index) => '');

  final titleRow2 = List.generate(10, (index) => '');

  final titleColumn = ['Tipo', 'Cantidad', 'Unidad de Venta', 'Frecuencia'];

  final titleColumn2 = [
    'Precio venta',
    'Total Compra\nMensual',
    'Total Venta\nMensual',
    'MUB'
  ];

  final TextEditingController s1 = TextEditingController(),
      s2 = TextEditingController(),
      s3 = TextEditingController();

  final scroll = ScrollControllers(
    horizontalBodyController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
    verticalTitleController: ScrollController(),
  );

  double _scrollOffsetX = 0.0;
  double _scrollOffsetY = 0.0;
  double _scrollOffsetX2 = 0.0;
  double _scrollOffsetY2 = 0.0;

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollControllers(
      horizontalBodyController:
          ScrollController(initialScrollOffset: _scrollOffsetX),
      verticalBodyController:
          ScrollController(initialScrollOffset: _scrollOffsetY),
      horizontalTitleController:
          ScrollController(initialScrollOffset: _scrollOffsetX),
      verticalTitleController:
          ScrollController(initialScrollOffset: _scrollOffsetY),
    );
    final scroll2 = ScrollControllers(
      horizontalBodyController:
          ScrollController(initialScrollOffset: _scrollOffsetX2),
      verticalBodyController:
          ScrollController(initialScrollOffset: _scrollOffsetY2),
      horizontalTitleController:
          ScrollController(initialScrollOffset: _scrollOffsetX2),
      verticalTitleController:
          ScrollController(initialScrollOffset: _scrollOffsetY2),
    );
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Costos'),
            actions: [Icon(Icons.more_vert)]),
        body: ChangeNotifierProvider<TableContent>(
          create: (context) => TableContent(),
          child:
              Consumer<TableContent>(builder: (context, tablecontent, widget) {
            s1.text = tablecontent.getSum1();
            s2.text = tablecontent.getSum2();
            s3.text = tablecontent.getSum3();
            Provider.of<Data>(context, listen: false)
                .setMUB(double.tryParse(s3.text) ?? 0);
            return Column(children: [
              Expanded(
                  flex: 1,
                  child: StickyHeadersTable(
                    scrollControllers: scroll,

                    initialScrollOffsetX: _scrollOffsetX,
                    initialScrollOffsetY: _scrollOffsetY,
                    onEndScrolling: (scrollOffsetX, scrollOffsetY) {
                      _scrollOffsetX = scrollOffsetX;
                      _scrollOffsetY = scrollOffsetY;
                    },
                    columnsLength: titleColumn.length,
                    rowsLength: titleRow.length,
                    columnsTitleBuilder: (i) => TableCel.stickyRow(
                      titleColumn[i],
                      textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                    rowsTitleBuilder: (i) => TableCel.content(
                      '',
                      controller: tablecontent.table[0][i],
                      onchange: (s) {
                        Provider.of<TableContent>(context, listen: false)
                            .setxy(0, i, s);
                      },
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                    contentCellBuilder: (i, j) => (i == 3)
                        ? DropdownM(i, j)
                        : TableCel.content(
                            '',
                            controller: tablecontent.table[i + 1][j],
                            onchange: (s) {
                              Provider.of<TableContent>(context, listen: false)
                                  .setxy(i + 1, j, s);
                            },
                            cellDimensions:
                                CellDimensions.uniform(width: 200, height: 200),
                          ),
                    // TableCell.content(
                    //   data[i][j],
                    //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                    // ),
                    legendCell: TableCel.legend(
                      'Producto o\nServicio',
                      textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                  )),
              SizedBox(
                height: 23,
              ),
              Expanded(
                  flex: 1,
                  child:
                      // Consumer<TableContent>(
                      //     builder: (context, tablecontent, widget) {
                      //   return
                      StickyHeadersTable(
                    scrollControllers: scroll2,

                    initialScrollOffsetX: _scrollOffsetX2,
                    initialScrollOffsetY: _scrollOffsetY2,
                    onEndScrolling: (scrollOffsetX, scrollOffsetY) {
                      _scrollOffsetX2 = scrollOffsetX;
                      _scrollOffsetY2 = scrollOffsetY;
                    },
                    columnsLength: titleColumn.length,
                    rowsLength: titleRow.length,
                    columnsTitleBuilder: (i) => TableCel.stickyRow(
                      titleColumn2[i],
                      textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                    rowsTitleBuilder: (i) => TableCel.content(
                      '',
                      controller: tablecontent.table[0][i + 10],
                      onchange: (s) {
                        Provider.of<TableContent>(context, listen: false)
                            .setxy(0, i + 10, s);
                      },
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                    contentCellBuilder: (i, j) => TableCel.content(
                      tablecontent.getxy(i + 1, 10 + j),
                      controller: tablecontent.table[i + 1][10 + j],
                      onchange: (s) {
                        Provider.of<TableContent>(context, listen: false)
                            .setxy(i + 1, 10 + j, s);
                      },
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                    // TableCell.content(
                    //   data[i][j],
                    //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                    // ),
                    legendCell: TableCel.legend(
                      'Precio Compra',
                      textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                      cellDimensions:
                          CellDimensions.uniform(width: 200, height: 200),
                    ),
                  )
                  // ;
                  // }
                  // )  ,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total:   '),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: s1,
                      readOnly: true,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: s2,
                      readOnly: true,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: s3,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 23,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'ayudaDiosito');
                  },
                  child: Text('Siguente'))
            ]);
          }),
        ));
  }
}

class DropdownM extends StatefulWidget {
  DropdownM(this.x, this.y, {Key? key}) : super(key: key);
  int x, y;
  @override
  _DropdownStateM createState() => _DropdownStateM();
}

class _DropdownStateM extends State<DropdownM> {
  String value = '-';

  Map<String, double> mp = {
    '-': 0,
    'Diario': 25,
    'Semanal': 4,
    'Mensual': 1,
    'Quincenal': 2,
    'Bimestral': 0.5,
    'Trimestral': 0.3,
    'Semestral': 1.0 / 6.0,
    'Anual': 1.0 / 12.0
  };
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        '-',
        'Diario',
        'Semanal',
        'Mensual',
        'Quincenal',
        'Bimestral',
        'Trimestral',
        'Semestral',
        'Anual'
      ]
          .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(fontSize: 12),
              )))
          .toList(),
      onChanged: (String? newValue) {
        Provider.of<TableContent>(context, listen: false)
            .setxy(4, widget.y, mp[newValue]!.toStringAsFixed(2));
        setState(() {
          value = newValue!;
        });
      },
      value: value,
    );
  }
}

class TableContent with ChangeNotifier {
  List<List<TextEditingController>> table = List.generate(
      5, (index) => List.generate(20, (i) => TextEditingController()));

  TableContent();
  double sum1 = 0, sum2 = 0, sum3 = 0;
  void setxy(int x, int y, String val) {
    if (x == 4) table[x][y].text = val;
    if (((x == 2 || x == 4) && y < 10)) {
      table[x][y + 10].text = ((double.tryParse(table[x][y].text) ?? 1) *
              (double.tryParse(table[0][y + 10].text) ?? 1) *
              (double.tryParse(table[4][y].text) ?? 1))
          .toStringAsFixed(4);

      table[4][y + 10].text = (((double.tryParse(table[3][y + 10].text) ?? 1) -
                  (double.tryParse(table[2][y + 10].text) ?? 1)) /
              (double.tryParse(table[3][y + 10].text) ?? 1))
          .toStringAsFixed(4);
    } else if (((x == 0 || x == 1) && y >= 10)) {
      table[x + 2][y].text = ((double.tryParse(table[2][y - 10].text) ?? 1) *
              (double.tryParse(table[x][y].text) ?? 1) *
              (double.tryParse(table[4][y - 10].text) ?? 1))
          .toStringAsFixed(4);
      table[4][y].text = (((double.tryParse(table[3][y].text) ?? 0) -
                  (double.tryParse(table[2][y].text) ?? 1)) /
              (double.tryParse(table[3][y].text) ?? 1))
          .toStringAsFixed(4);
    }
    sum1 = getsum(2);
    sum2 = getsum(3);
    sum3 = (sum2 - sum1) / sum2;
    notifyListeners();
  }

  double getsum(x) {
    double res = 0;
    for (int i = 10; i < 20; i++)
      res += (double.tryParse(table[x][i].text) ?? 0);
    return res;
  }

  String getSum1() => sum1.toStringAsFixed(4);
  String getSum2() => sum2.toStringAsFixed(4);
  String getSum3() => sum3.toStringAsFixed(4);
  String getxy(int x, int y) => table[x][y].text;
}
