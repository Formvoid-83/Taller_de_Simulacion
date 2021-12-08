import 'package:app/Data.dart';
import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/cell_dimensions.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class PrespsTotalCont extends StatefulWidget {
  const PrespsTotalCont({Key? key}) : super(key: key);

  @override
  _PrespsTotalState createState() => _PrespsTotalState();
}

class _PrespsTotalState extends State<PrespsTotalCont> {
  final c = TextEditingController();

  List<List<String>> data =
      List.generate(3, (index) => List.generate(3, (index) => ''));

  List<List<String>> data2 =
      List.generate(6, (index) => List.generate(6, (index) => ''));

  setxy(x, y, s) {
    data2[x][y] = s;
  }

  double sumColumn() {
    double res = 0;
    res = data2[1]
        .fold(0, (prev, e) => (e == '') ? prev : prev += double.tryParse(e)!);
    return res;
  }

  final List<String> titleColumn = [
    '',
  ];

  final List<String> titleColumn2 = [
    '',
  ];

  final List<String> titleColumn3 = [
    '',
  ];
  final List<String> titleRow = [
    'APORTE PROPIO',
    '% DE APORTE PROPIO',
  ];

  final List<String> titleRow2 = [
    'PRIMER\n DESEMBOLSO',
    'SEGUNDO \n DESEMBOLSO',
  ];

  Widget getCell(int x, int y, context, key, b) {
    final CellDimensions cellDimensions;
    final String text;
    final double? cellWidth;
    final double? cellHeight;
    final Color colorBg;
    final Color _colorHorizontalBorder;
    final Color _colorVerticalBorder;
    final TextAlign _textAlign;
    final EdgeInsets _padding;
    final TextStyle? textStyle;

    cellDimensions = CellDimensions.base;
    colorBg = Colors.white;

    cellWidth = cellDimensions.contentCellWidth;
    cellHeight = cellDimensions.contentCellHeight;
    _colorHorizontalBorder = Colors.amber;
    _colorVerticalBorder = Colors.black38;
    _textAlign = TextAlign.center;
    _padding = EdgeInsets.zero;

    return GestureDetector(
      child: Container(
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(border: InputBorder.none),
                  initialValue: data2[x][y],
                    keyboardType: TextInputType.number,
                  onChanged: (s) {
                    setxy(x, y, s);

                    setState(() {});
                  },
                  // style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<String>? param =
        ModalRoute.of(context)!.settings.arguments as List<String>?;
    final String key = param![0];
    final String title = param[1];
    final t1 = Provider.of<Data>(context, listen: false).getT1();
    final t2 = Provider.of<Data>(context, listen: false).getT2();
    final ape = Provider.of<Data>(context, listen: false).getAPE();
    final efec = Provider.of<Data>(context, listen: false).getEfec();
    print('ape:$ape  efec:$efec t1:$t1  t2:$t2   '); 
    titleColumn[0] = (t1 + t2 - efec).toStringAsFixed(2);
    data[0][0] = t1.toStringAsFixed(2);
    if (t1 + t2 - efec != 0)
      data[0][1] = ((t1 / (t1 + t2 - efec)) * 100).toStringAsFixed(2);
    else
      data[0][1] = (0).toStringAsFixed(2);
    titleColumn2[0] = 'Bs. ${(t2 - efec).toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                child: StickyHeadersTable(
                  columnsLength: titleColumn.length,
                  rowsLength: titleRow.length,
                  columnsTitleBuilder: (i) => TableCel.stickyRow(
                    titleColumn[i],
                    textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                    cellDimensions: CellDimensions.uniform(
                        width: 300, height: double.infinity),
                  ),
                  rowsTitleBuilder: (i) => TableCel.stickyRow(
                    titleRow[i],
                    textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                    cellDimensions: CellDimensions.uniform(
                        width: 200, height: double.infinity),
                  ),
                  contentCellBuilder: (i, j) =>
                      // getCell(i, j, context, key, true ),
                      TableCel.content(
                    data[i][j],
                    //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                  ),
                  legendCell: TableCel.legend(
                    'TOTAL PROYECTO',
                    textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                  ),
                ),
              ),
              Container(
                child: Text(
                    'APORTE PROPIO PARA GARANTIA HIPOTEC SER 10% Y PARA OTRA GARANTIA 20%'),
              ),
              Container(
                height: 100,
                child: StickyHeadersTable(
                  columnsLength: titleColumn2.length,
                  rowsLength: 0,
                  columnsTitleBuilder: (i) => TableCel.stickyRow(
                    titleColumn2[i],
                    textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                    cellDimensions: CellDimensions.uniform(
                        width: 300, height: double.infinity),
                  ),
                  rowsTitleBuilder: (i) => TableCel.stickyRow(
                    titleRow[i],
                    textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                    cellDimensions: CellDimensions.uniform(
                        width: 200, height: double.infinity),
                  ),
                  contentCellBuilder: (i, j) =>
                      getCell(i, j, context, key, true),
                  // TableCell.content(
                  //   data[i][j],
                  //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                  // ),
                  legendCell: TableCel.legend(
                    'MONTO A FINANCIAR',
                    textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: StickyHeadersTable(
                    columnsLength: titleColumn3.length,
                    rowsLength: titleRow2.length,
                    columnsTitleBuilder: (i) => Container(),
                    //  TableCel.stickyRow(
                    //   titleColumn3[i],
                    //   textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                    //   cellDimensions: CellDimensions.uniform(width: 300, height: double.infinity),

                    //   ),
                    rowsTitleBuilder: (i) => TableCel.stickyRow(
                          titleRow2[i],
                          textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                          cellDimensions: CellDimensions.uniform(
                              width: 200, height: double.infinity),
                        ),
                    contentCellBuilder: (i, j) =>
                        getCell(i, j, context, key, true),
                    // TableCell.content(
                    //   data[i][j],
                    //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                    // ),
                    legendCell: Container()
                    // TableCel.legend(
                    //   'PRIMER  DESEMOLSO',
                    //   textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                    // ),
                    ),
              ),
              Container(
                child: Text('DESEMBOLSO\n ${ ( double.tryParse(data2[0][0]) != null && double.tryParse(data2[0][1])!= null  &&   double.parse(data2[0][0]) + double.parse(data2[0][1]) == t2 - efec ) ? "CORRECTO":"INCORRECTO"} '),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  child: Text(
                      'APORTE PROPIO \n  ${(ape == efec) ? "CORRECTO" : "INCORRECTO"}')),
            ],
          ),
        ),
      ),
    );
  }
}
