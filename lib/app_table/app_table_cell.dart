import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_table_edit_cell.dart';

class AppTableCell {
  /// 绘制Cell组件
  final WidgetBuilder builder;

  /// 单元格的宽度
  final double height;

  /// 单元格背景颜色
  final Color backgroundColor;

  /// 单元格选中时的背景颜色
  final Color? selectRowColor;

  /// 布局方式 默认居中
  final AlignmentGeometry alignment;

  /// 设置单元格的内边距
  final EdgeInsets padding;

  /// 默认初始化
  /// [builder] 自定义绘制Cell组件
  /// [height] 单元格的高度
  /// [backgroundColor] 单元格的背景颜色
  /// [selectRowColor] 单元格选中时的背景颜色
  AppTableCell({
    required this.builder,
    this.height = 40,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.selectRowColor,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(0),
  });

  /// 创建一个空的Cell
  factory AppTableCell.empty() => AppTableCell(builder: (_) => Container());

  /// 创建一个展示文本的 Cell
  /// [text] 文本内容
  /// [textStyle] 文本样式
  /// [height] 文本对齐方式
  /// [backgroundColor] 单元格的背景颜色
  /// [selectRowColor] 单元格选中时的背景颜色
  factory AppTableCell.text({
    required String text,
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF333333),
    ),
    double height = 40,
    Color backgroundColor = const Color(0xFFFFFFFF),
    Color? selectRowColor,
    AlignmentGeometry alignment = Alignment.center,
    EdgeInsets padding = const EdgeInsets.all(0),
    Key? key,
  }) =>
      AppTableCell(
        builder: (context) => Text(text, style: textStyle, key: key),
        height: height,
        backgroundColor: backgroundColor,
        selectRowColor: selectRowColor,
        alignment: alignment,
        padding: padding,
      );

  /// 创建一个可以编辑的Cell
  /// [text] 文本内容
  /// [textStyle] 文本样式
  /// [height] 文本对齐方式
  /// [backgroundColor] 单元格的背景颜色
  /// [controller] 文本控制器
  /// [selectRowColor] 单元格选中时的背景颜色
  factory AppTableCell.textEdit({
    required String text,
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF333333),
    ),
    double height = 40,
    Color backgroundColor = const Color(0xFFFFFFFF),
    TextEditingController? controller,
    Color? selectRowColor,
    AlignmentGeometry alignment = Alignment.center,
    EdgeInsets padding = const EdgeInsets.all(0),
    List<TextInputFormatter> inputFormatters = const [],
    TextInputType? keyboardType,
    Key? key,
    ValueChanged<String?>? onSubmitted,
  }) =>
      AppTableCell(
        builder: (context) => AppTableEditCell(
          text: text,
          textStyle: textStyle,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          key: key,
          onSubmitted: onSubmitted,
        ),
        height: height,
        backgroundColor: backgroundColor,
        selectRowColor: selectRowColor,
        alignment: alignment,
        padding: padding,
      );

  bool _isSelect = false;

  bool get isSelected => _isSelect;

  set isSelected(bool value) {
    if (_isSelect == value) return;
    _isSelect = value;
  }

  Color get selectBackgroundColor => selectRowColor ?? backgroundColor;
}
