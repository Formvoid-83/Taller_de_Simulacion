import 'package:app/Data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class TableCel extends StatelessWidget {
  TableCel.content(this.text,
      {this.textStyle,
      this.cellDimensions = CellDimensions.base,
      this.colorBg = Colors.white,
      this.onTap,
      this.onchange,
      this.readonly,
      this.controller})
      : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCel.legend(this.text,
      {this.textStyle,
      this.cellDimensions = CellDimensions.base,
      this.colorBg = Colors.amber,
      this.onTap,
      this.onchange,
      this.readonly,
      this.controller})
      : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  TableCel.stickyRow(this.text,
      {this.textStyle,
      this.cellDimensions = CellDimensions.base,
      this.colorBg = Colors.amber,
      this.onTap,
      this.onchange,
      this.readonly,
      this.controller})
      : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCel.stickyColumn(this.text,
      {this.textStyle,
      this.cellDimensions = CellDimensions.base,
      this.colorBg = Colors.white,
      this.onTap,
      this.onchange,
      this.readonly,
      this.controller})
      : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;
  final TextEditingController? controller;
  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;
  final bool? readonly;
  final TextStyle? textStyle;
  final Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                readOnly: readonly ?? false,
                initialValue: (controller == null) ? text : null,
                style: textStyle,
                maxLines: 2,
                textAlign: _textAlign,
                onChanged: onchange,
                controller: controller,
              ),
            )),
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
}

class TableCelWidget extends StatelessWidget {
  TableCelWidget.content(
    this.child, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCelWidget.legend(
    this.child, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  TableCelWidget.stickyRow(
    this.child, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCelWidget.stickyColumn(
    this.child, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  final CellDimensions cellDimensions;

  final Widget child;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;
  // final TextEditingController?
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  child: child),
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
}
