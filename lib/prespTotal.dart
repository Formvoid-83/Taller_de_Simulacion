import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:app/asxs.dart';

class PrespsTotal extends StatefulWidget {
  const PrespsTotal({Key? key}) : super(key: key);

  @override
  _PrespsTotalState createState() => _PrespsTotalState();
}

class _PrespsTotalState extends State<PrespsTotal> {
  
  
  final c = TextEditingController();
  
    List<List<String>> data =
      List.generate(1, (index) => List.generate(1, (index) => ''));
      
      
    List<List<String>> data2 =
      List.generate(6, (index) => List.generate(6, (index) => ''));

  setxy(x, y, s )
  {
    data2[x][y]  = s; 
    
  }   


  double sumColumn()
  {
    double res = 0 ;
    res = data2[1].fold(0, (prev, e) => (e == '')? prev : prev+= double.tryParse(e)!);  
    return res ; 
  }
  final List<String> titleColumn = [
    'MONTO TOTAL',
  
  ];

    final List<String> titleColumn2 = [
    'MONTO TOTAL',
    'AP. PROPIO\n EFECTIVO',
  ];
  final List<String> titleRow = [
    'Efectivo',
    'Mano de Obra',
    'Materia Prima',
    'Requerimientos Promocionales',
    'Infraestructura/terrenos\n y/o plantines',
    'Maquinaria Equipos\n Vehículos',
    'Requerimientos\n Legales ',

  ];

  final List<String> titleRow2 = [
    'Mano de Obra',
    'Materia Prima',
    'Requerimientos Promocionales',
    'Infraestructura/terrenos\n y/o plantines',
    'Maquinaria Equipos\n Vehículos',
    'Requerimientos\n Legales ',
  ];


  Widget getCell(int x, int y, context, key , b) {
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
                  initialValue: (b) ? data[x][y] : data2[x][y],
                  onChanged: (s) {
                    setxy(x, y, s);
                    var aux = '${sumColumn()}';
                    setState(() {

                    c.text = aux ;
                    });
                    
                    Provider.of<Data>(context).setAPE(aux); 
                    
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
    final String title = param[1] ;

    data[0] = Provider.of<Data>(context , listen:false ).getAporteList(); 
    data2[0] = Provider.of<Data>(context, listen:false).getInvertidoList(); 
    
    double sumAP = data[0].fold(0, (prev, e) => prev += double.parse(e));
    double sumINV = data2[0].fold(0, (prev, e) => prev += double.parse(e));
    
    Provider.of<Data>(context, listen: false).sett1(sumAP); 
    Provider.of<Data>(context, listen: false).sett2(sumINV); 
    return
    Scaffold(

       appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(title),
          actions: [Icon(Icons.more_vert)]),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Presupuesto resumen '), 
            Container(
              height: 400,
              width:double.infinity, 
                   child: StickyHeadersTable(
            columnsLength: titleColumn.length,
            rowsLength: titleRow.length,
            columnsTitleBuilder: (i) => TableCel.stickyRow(
              titleColumn[i],
              textStyle: textTheme.button!.copyWith(fontSize: 15.0),
              cellDimensions: CellDimensions.uniform(width: 300, height: double.infinity),
              
              ),
            rowsTitleBuilder: (i) => TableCel.stickyRow(
              titleRow[i],
              textStyle: textTheme.button!.copyWith(fontSize: 15.0),
              cellDimensions: CellDimensions.uniform(width: 200, height: double.infinity),
             ),
            contentCellBuilder: (i, j) => getCell(i, j, context, key, true ),
            // TableCell.content(
            //   data[i][j],
            //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
            // ),
            legendCell: TableCel.legend(
              'APORTE PROPIO',
              textStyle: textTheme.button!.copyWith(fontSize: 16.5),
            ),
          )
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
              Text('Total'),
               Container(
                 width: 100, 
                 child: TextFormField(
                  //  controller: a ,
                    enabled: false,
                    initialValue: sumAP.toStringAsFixed(2),
                 )
               ),             
              ]
            ), 
            Text('Plan de inversion '), 
            Container(
              height: 400,
              width: double.infinity,
                   child: StickyHeadersTable(
            columnsLength: titleColumn2.length,
            rowsLength: titleRow2.length,
            columnsTitleBuilder: (i) => TableCel.stickyRow(
              titleColumn2[i],
              textStyle: textTheme.button!.copyWith(fontSize: 15.0),
            ),
            rowsTitleBuilder: (i) => TableCel.stickyRow(
              titleRow2[i],
              textStyle: textTheme.button!.copyWith(fontSize: 15.0),
              cellDimensions: CellDimensions.uniform(width: 200, height: double.infinity),
                
             ),
            contentCellBuilder: (i, j) => getCell(i, j, context, key, false ),
            // TableCell.content(
            //   data[i][j],
            //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
            // ),
            legendCell: TableCel.legend(
              'APORTE PROPIO',
              textStyle: textTheme.button!.copyWith(fontSize: 16.5),
            ),
          ),
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
              Text('Total'),
              Container(
                width: 100, 
                child: TextFormField(
                  // controller: b ,
                  initialValue: sumINV.toStringAsFixed(2),
                )
              ),              
              Container(
                width: 100, 
                child: TextFormField(
                  controller: c ,

                )
              ),
              ]
            ), 
            
            ElevatedButton(onPressed: ()
            {
              Navigator.pushNamed(context, 'PrespTotalCont', arguments: ['', 'Presupuesto total']); 
            }, child: Text('Continuar')),
          ],
        ),
      ),
    );
  }
}