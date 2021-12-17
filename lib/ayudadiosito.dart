import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'Data.dart';

class AyudaDiosito extends StatefulWidget {
  AyudaDiosito({Key? key}) : super(key: key);

  @override
  _AyudaDiositoState createState() => _AyudaDiositoState();
}

class _AyudaDiositoState extends State<AyudaDiosito> {
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

  final scroll = ScrollControllers(
      horizontalBodyController: ScrollController(), 
      verticalBodyController:  ScrollController(), 
      horizontalTitleController: ScrollController(), 
      verticalTitleController: ScrollController(), 
      
      );


  @override
  Widget build(BuildContext context) {
    TextEditingController A = TextEditingController(),
        M = TextEditingController(),
        B = TextEditingController();
    double _scrollOffsetX = 0.0;
    double _scrollOffsetY = 0.0;

    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Costos '),
            actions: [Icon(Icons.more_vert)]),
        body: ChangeNotifierProvider<Values>(
            create: (context) =>
                Values(Provider.of<Data>(context, listen: false).getMUB()),
            child: Consumer<Values>(builder: (context, values, widget) {
              // print(values.valuesD);
              // print(values.valuesI);
              // print(values.MUB);

              Provider.of<Data>(context, listen: false)
                  .setTVentas(values.getsumD());
              Provider.of<Data>(context, listen: false)
                  .setTCostos(values.getsumI());
              return Container(
                  height: MediaQuery.of(context).size.height * 2,
                  child: Column(
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
                                controller: A,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  Provider.of<Values>(context, listen: false)
                                      .setAlta((double.tryParse(s) ?? 0));
                                },
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
                                controller: M,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  Provider.of<Values>(context, listen: false)
                                      .setMedia((double.tryParse(s) ?? 0));
                                },
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
                                controller: B,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  Provider.of<Values>(context, listen: false)
                                      .setBaja((double.tryParse(s) ?? 0));
                                },
                              ),
                            )
                          ],
                        ),
                        Expanded(
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
                              cellDimensions: CellDimensions.uniform(
                                  width: 300, height: double.infinity),
                              // textStyle: textTheme.button!.copyWith(fontSize: 15.0),
                            ),
                            rowsTitleBuilder: (i) => TableCel.stickyRow(
                              titleRow[i],
                              cellDimensions: CellDimensions.uniform(
                                  width: 200, height: double.infinity),
                            ),
                            contentCellBuilder: (i, j) {
                              if (i == 0 && j != 12)
                                return TableCelWidget.content(DropdownP(i, j));
                              else if (j == 12)
                                return TableCelWidget.content(Text((i == 0)
                                    ? values.getXYstrD(i, j)
                                    : values.getXYstrI(i, j)));
                              else
                                return TableCelWidget.content(
                                    Text(values.getXYstrI(i, j)));
                            },
                            // TableCell.content(
                            //   data[i][j],
                            //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            // ),
                            legendCell: TableCel.legend(
                              'Mes',
                              // textStyle: textTheme.button!.copyWith(fontSize: 16.5),
                            ),
                          ),
                        )
                      ]));
            })));
  }
}

class DropdownP extends StatefulWidget {
  DropdownP(this.x, this.y, {Key? key}) : super(key: key);
  final int x;
  final int y;
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<DropdownP> {
  String value = '-';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: ['-', 'A', 'M', 'B']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? newValue) {
        print("${widget.x} , ${widget.y} ");
        Provider.of<Values>(context, listen: false)
            .setXY(widget.x, widget.y, newValue!);
        setState(() {
          value = newValue;
        });
      },
      value: value,
    );
  }
}

class Values with ChangeNotifier {
  final valuesD = List.filled(13, '');
  final valuesI = List.filled(13, '');
  final double MUB;
  double sumD = 0, sumI = 0;

  Map<String, double> mp = {'A': 0, 'M': 0, 'B': 0};
  Values(this.MUB);

  void setAlta(x) {
    mp['A'] = x;
    notifyListeners();
  }

  void setMedia(x) {
    mp['M'] = x;
    notifyListeners();
  }

  void setBaja(x) {
    mp['B'] = x;
    notifyListeners();
  }

  void setXYbruh(int x, int y, String val) {
    valuesI[y] = val;

    notifyListeners();
  }

  void setXY(int x, int y, String val) {
    valuesD[y] = mp[val]!.toStringAsFixed(4);

    valuesI[y] = (mp[val]! * (1 - MUB)).toStringAsFixed(4);

    sumD = sum(0);
    sumI = sum(1);
    valuesD[12] = sumD.toStringAsFixed(4);
    valuesI[12] = sumI.toStringAsFixed(4);
    notifyListeners();
  }

  double sum(x) {
    double res = 0;
    for (int i = 0; i <= 11; i++)
      res += double.tryParse((x == 0) ? valuesD[i] : valuesI[i]) ?? 0;
    return res;
  }

  String getXYstrD(int x, int y) => valuesD[y].split(".").first;
  String getXYstrI(int x, int y) => valuesI[y].split(".").first;
  double getXYD(int x, int y) => double.tryParse(valuesD[y]) ?? 0;
  double getXYI(int x, int y) => double.tryParse(valuesI[y]) ?? 0;
  double getAlta() => mp['A']!;
  double getMedia() => mp['M']!;
  double getBaja() => mp['B']!;

  double getsumD() => sumD;
  double getsumI() => sumI;
}
