import 'package:app/Data.dart';
import 'package:app/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app/asxs.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class TableView extends StatefulWidget {
  TableView({Key? key}) : super(key: key);

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  final columns = 5;
  final rows = 20;
  final total1 = TextEditingController();
  final total2 = TextEditingController();

  List<List<String>> data =
      List.generate(6, (index) => List.generate(20, (index) => ''));

  final List<String> titleColumn = [
    'Unidad',
    'Cantidad',
    'Precio',
    'Aporte Propio',
    'Invertido'
  ];
  final List<String> titleRow = List.generate(20, (i) => '');

  setxy(int x, int y, String s) {
    data[x][y] = s;
  }

  double sumColumn(index) {
    double res = 0;
    data[index].forEach((element) {
      if (element != '') res += double.tryParse(element)!;
    });

    return res;
  }

  void checkMul(x, y) {}

  List<List<String>> getData() {
    return data;
  }

  Widget getCell(int x, int y, context, key) {
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
                  initialValue: data[x][y],
                  onChanged: (s) {
                    setxy(x, y, s);

                    Provider.of<Data>(context, listen: false)
                        .addList(key, data);
                    if (x == 2 || x == 3) {
                      if (data[2][y] != '' && data[3][y] != '') {
                        data[5][y] = (double.parse(data[2][y]) *
                                double.parse(data[3][y]))
                            .toStringAsFixed(2);
                      }
                    }
                          total1.text = '${sumColumn(4)}';

                      total2.text = '${sumColumn(5)}';
                    print('$x ,$y');
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

  Widget getRowCell(int x, context, key) {
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

    cellWidth = cellDimensions.stickyLegendWidth;
    cellHeight = cellDimensions.stickyLegendHeight;
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
                  initialValue: data[0][x],
                  onChanged: (s) {
                    setxy(0, x, s);

                    Provider.of<Data>(context, listen: false)
                        .addList(key, data);
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

   double _scrollOffsetX = 0.0;
    double _scrollOffsetY = 0.0;
 

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollControllers(
    horizontalBodyController: ScrollController(initialScrollOffset: _scrollOffsetX),
    verticalBodyController: ScrollController(initialScrollOffset: _scrollOffsetY),
    horizontalTitleController: ScrollController(initialScrollOffset: _scrollOffsetX),
    verticalTitleController: ScrollController(initialScrollOffset: _scrollOffsetY),
  );
    final textTheme = Theme.of(context).textTheme;
    final List<String>? param =
        ModalRoute.of(context)!.settings.arguments as List<String>?;
    final String key = param![0];
    final String title = param[1];
    final list = Provider.of<Data>(context, listen: false).getList(key);
    Text info = Text('');
    if (Provider.of<Data>(context, listen: false).getList(key).isNotEmpty) {
      data = Provider.of<Data>(context, listen: false).getList(key);
    }


    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body: Column(children: [
        Expanded(
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
          ),
          rowsTitleBuilder: (i) => getRowCell(i, context, key),
          contentCellBuilder: (i, j) => getCell(i + 1, j, context, key),
          // TableCell.content(
          //   data[i][j],
          //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
          // ),
          legendCell: TableCel.legend(
            'Detalle',
            textStyle: textTheme.button!.copyWith(fontSize: 16.5),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Sub-Total :  '),
            Container(
              width: 100,
              child: TextFormField(
                controller: total1,
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                controller: total2,
              ),
            )
          ],
        )
      ]),
    );
  }
}
