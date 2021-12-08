import 'package:app/asxs.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class Costos extends StatefulWidget {
  Costos({Key? key}) : super(key: key);

  @override
  _CostosState createState() => _CostosState();
}

class _CostosState extends State<Costos> {

  final titleRow =  ['','',''];

  final titleRow2 =  ['','',''];

  final titleColumn =  ['Tipo','Cantidad','Unidad de Venta', 'Frecuencia'];

  final titleColumn2 =  ['Precio venta','Total Compra\nMensual','Total Venta\nMensual', 'MUB'];


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
      body: Column(
        children:[
          Expanded(
            flex: 1,
            child:StickyHeadersTable(
          columnsLength: titleColumn.length,
          rowsLength: titleRow.length,
          columnsTitleBuilder: (i) => TableCel.stickyRow(
            titleColumn[i],
            textStyle: textTheme.button!.copyWith(fontSize: 15.0),
          ),
          rowsTitleBuilder: (i) => TableCel.stickyRow('',
              cellDimensions: CellDimensions.uniform(width: 200, height: double.infinity),
          
          ),
          contentCellBuilder: (i, j) => TableCel.content(''),
          // TableCell.content(
          //   data[i][j],
          //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
          // ),
          legendCell: TableCel.legend(
            'Producto o\nServicio',
            textStyle: textTheme.button!.copyWith(fontSize: 16.5),
          ),
        ),
          ),
          SizedBox(height: 23 ,),
          Expanded(
            flex: 1,
            child: 
            StickyHeadersTable(
          columnsLength: titleColumn.length,
          rowsLength: titleRow.length,
          columnsTitleBuilder: (i) => TableCel.stickyRow(
            titleColumn2[i],
            textStyle: textTheme.button!.copyWith(fontSize: 15.0),
          ),
          rowsTitleBuilder: (i) => TableCel.stickyRow('',
              cellDimensions: CellDimensions.uniform(width: 200, height: double.infinity),
          
          ),
          contentCellBuilder: (i, j) => TableCel.content(''),
          // TableCell.content(
          //   data[i][j],
          //   textStyle: textTheme.bodyText2!.copyWith(fontSize: 15.0),
          // ),
          legendCell: TableCel.legend(
            'Precio Compra',
            textStyle: textTheme.button!.copyWith(fontSize: 16.5),
          ),
        ), 
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Total:   '),
               Container(
                width: 100,
                child: TextFormField(
                    readOnly: true,
                ),
               ),
                Container(
                width: 100,
                child: TextFormField(
                  readOnly: true,
                ),),
                 Container(
                width: 100,
                child: TextFormField(
                  readOnly: true,
                ),),
            ],
          ),
          SizedBox(height: 23 ,),
          ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'costossig',arguments: ['', 'Costos']);}, child: Text('Siguente'))
        ]
      ),
    );
  }
}
