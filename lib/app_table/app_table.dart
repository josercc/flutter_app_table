import 'package:flutter/material.dart';
import 'package:flutter_app_table/app_table/app_table_cell.dart';
import 'package:flutter_app_table/app_table/app_table_controller.dart';
import 'package:provider/provider.dart';

typedef AppTableColumnBuilder = AppTableCell Function(int column);
typedef AppTableRowBuilder = AppTableCell Function(int row, int column);
typedef AppTableColumnWidthBuilder = TableColumnWidth Function(int column);
typedef AppTableRowDecorationBuilder = Decoration? Function(int column);

/// 基于 Table 的表格封装
class AppTable extends StatefulWidget {
  /// 列数
  final int columnCount;

  /// 行数
  final int rowCount;

  /// 默认列宽度 默认为100
  final double defaultColumnWidth;

  /// 构建表内容
  final AppTableRowBuilder? rowBuilder;

  /// 构建表头
  final AppTableColumnBuilder? headerBuilder;

  /// 表头宽度
  final AppTableColumnWidthBuilder? columnWidthBuilder;

  final Decoration? headerDecoration;
  final AppTableRowDecorationBuilder? rowDecorationBuilder;

  /// 表格边框
  final TableBorder? border;

  /// 表格控制器
  final AppTableController? controller;

  const AppTable({
    Key? key,
    required this.columnCount,
    this.rowCount = 0,
    this.defaultColumnWidth = 100,
    this.headerBuilder,
    this.rowBuilder,
    this.columnWidthBuilder,
    this.border,
    this.controller,
    this.headerDecoration,
    this.rowDecorationBuilder,
  }) : super(key: key);

  @override
  State<AppTable> createState() => _AppTableState();
}

class _AppTableState extends State<AppTable> {
  late AppTableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AppTableController();
  }

  @override
  void didUpdateWidget(covariant AppTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    final tableController = widget.controller ?? _controller;
    if (tableController != _controller) {
      _controller = tableController;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 修复 因为设置 columnCount = 0 报错
    if (widget.columnCount == 0) return Container();
    return Material(
      color: Colors.transparent,
      child: Table(
        border: widget.border ?? _normalBorder,
        columnWidths: _columnWidths,
        children: _cellContents(context),
      ),
    );
  }

  TableBorder get _normalBorder {
    return TableBorder.all(
      color: const Color(0xFFE5E5E5),
      width: 1,
    );
  }

  Map<int, TableColumnWidth> get _columnWidths {
    final Map<int, TableColumnWidth> columnWidths = {};
    for (var i = 0; i < widget.columnCount; i++) {
      columnWidths[i] = _getColumnWidth(i);
    }
    return columnWidths;
  }

  /// 根据 column 获取宽度
  TableColumnWidth _getColumnWidth(int column) {
    final columnWidthBuilder = widget.columnWidthBuilder;
    if (columnWidthBuilder != null) {
      return columnWidthBuilder(column);
    }
    return FixedColumnWidth(widget.defaultColumnWidth);
  }

  /// 获取布局的Cell 内容
  List<TableRow> _cellContents(BuildContext context) {
    List<TableRow> rows = [];

    /// 构建 Header
    final headerBuilder = widget.headerBuilder;
    if (headerBuilder != null) {
      rows.add(TableRow(
        decoration: widget.headerDecoration,
        children: List.generate(widget.columnCount, (column) {
          return _cellContent(
            notifier: _controller.columnNotifier(column),
            context: context,
            cellBuilder: () => headerBuilder(column),
          );
        }),
      ));
    }

    final rowBuilder = widget.rowBuilder;
    if (rowBuilder != null) {
      rows.addAll(List.generate(widget.rowCount, (index) {
        return TableRow(
          decoration: widget.rowDecorationBuilder?.call(index),
          children: List.generate(widget.columnCount, (column) {
            return _cellContent(
              notifier: _controller.rowNotifier(index, column),
              context: context,
              cellBuilder: () => rowBuilder(index, column),
            );
          }),
        );
      }));
    }

    return rows;
  }

  Widget _cellContent({
    required ValueNotifier<int> notifier,
    required BuildContext context,
    required AppTableCell Function() cellBuilder,
  }) {
    return ChangeNotifierProvider.value(
      value: notifier,
      builder: (context, child) {
        return Consumer<ValueNotifier<int>>(
          builder: (context, value, child) {
            final cell = cellBuilder();
            return Container(
              height: cell.height,
              color: cell.backgroundColor,
              width: double.infinity,
              padding: cell.padding,
              child: Align(
                alignment: cell.alignment,
                child: cell.builder(context),
              ),
            );
          },
        );
      },
    );
  }
}
