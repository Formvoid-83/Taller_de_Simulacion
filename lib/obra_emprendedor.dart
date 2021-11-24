import 'package:app/Data.dart';
import 'package:app/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app/asxs.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ObraEmprendedor extends StatefulWidget {
  ObraEmprendedor({Key? key}) : super(key: key);

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<ObraEmprendedor> {

  final columns = 3;
  final rows = 1;
  final total1 = TextEditingController();
  final total2 = TextEditingController();
  
   List<List<String>> data =
      [['Global'], ['1'] , ['0']];
      
  final List<String> titleColumn = [
    'Unidad',
    'Cantidad',
    'Aporte Propio',
  ];
  final List<String> titleRow = ['Mano de obra\n del emprendedor '];

  setxy(int x, int y, String s) {
    data[x][y] = s;
  }

  List<List<String>> getData() {
    return data;
  }

  Widget getCell(int x, int y, context) {
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
        width: 200,
        height: 100,
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
                    
                    // Provider.of<Data>(context, listen:false).addList(key, data);
                    // if(x == 1 || x ==2 ){
                    // if(data[1][y] != '' && data[2][y] != '' ){
                      
                    //     data[3][y] = (double.parse(data[1][y]) * double.parse(data[2][y])).toStringAsFixed(2); 
                        
                    //   }
                    //   }
                    
                   
                    setState(() {
                    });
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final List<String>? param =
    //     ModalRoute.of(context)!.settings.arguments as List<String>?;
    // final String key = param![0];
    // final String title = param[1] ;

    Text info = Text('');
     
     data[2][0] = Provider.of<Data>(context).getTotalAporte().toStringAsFixed(2); 
     total1.text =  Provider.of<Data>(context).getTotalAporte().toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Mano de obra emprendedor  '),
          actions: [Icon(Icons.more_vert)]),
      body: Column(children: [
        Expanded(
            child: StickyHeadersTable(
          columnsLength: titleColumn.length,
          rowsLength: titleRow.length,
          columnsTitleBuilder: (i) => TableCel.stickyRow(
            titleColumn[i],
            cellDimensions: CellDimensions.uniform(width: 200, height: 200),
            textStyle: textTheme.button!.copyWith(fontSize: 15.0),
          ),
          rowsTitleBuilder: (i) => TableCel.stickyColumn(
            titleRow[i],
            cellDimensions: CellDimensions.uniform(width: 200, height: 200),
            textStyle: textTheme.button!.copyWith(fontSize: 15.0),
          ),
          contentCellBuilder: (i, j) => getCell(i, j, context),
          // TableCell.content(
          //   data[i][j],
          //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
          // ),
          legendCell: TableCel.legend(
            'Detalle',
            cellDimensions: CellDimensions.uniform(width: 200, height: 200),
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
         
          ],
        )
      ]),
    );
  }
}
