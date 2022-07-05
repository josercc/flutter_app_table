/// 表格单元格 索引
class AppTableIndexPath {
  /// 行索引
  final int row;

  /// 列索引
  final int column;

  /// 初始化
  /// [row] 行索引
  /// [column] 列索引
  const AppTableIndexPath({
    required this.row,
    required this.column,
  });
}
