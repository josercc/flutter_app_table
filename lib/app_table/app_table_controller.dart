import 'package:flutter/material.dart';
import 'package:flutter_app_table/app_table/app_table_index_path.dart';

/// AppTable 控制器
class AppTableController {
  /// 表格单元格数据
  final Map<String, ValueNotifier<int>> _cellMap = {};

  AppTableController();

  /// 获取 header 对应 Column 数据
  /// [column] 列索引
  /// [row] 行索引
  ValueNotifier<int> columnNotifier(int column) {
    final key = rowCellKey(-1, column);
    final notifier = ValueNotifier(0);
    _cellMap[key] = notifier;
    return notifier;
  }

  /// 获取 row 对应 Row 数据
  /// [row] 行索引
  /// [column] 列索引
  ValueNotifier<int> rowNotifier(int row, int column) {
    final key = rowCellKey(row, column);
    final notifier = ValueNotifier(0);
    _cellMap[key] = notifier;
    return notifier;
  }

  String rowCellKey(int row, int column) {
    return 'row-$row-column-$column';
  }

  /// 刷新单个单元格
  /// [indexPaths] 单元格索引
  void reloadRow(List<AppTableIndexPath> indexPaths) {
    for (var indexPath in indexPaths) {
      final key = rowCellKey(indexPath.row, indexPath.column);
      final notifier = _cellMap[key];
      if (notifier != null) {
        notifier.value = notifier.value + 1;
      }
    }
  }

  /// 刷新 header
  /// [indexPaths] 单元格索引
  void reloadHeader(List<int> columns) {
    for (var column in columns) {
      final key = rowCellKey(-1, column);
      final notifier = _cellMap[key];
      if (notifier != null) {
        notifier.value = notifier.value + 1;
      }
    }
  }
}
