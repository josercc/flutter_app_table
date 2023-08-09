一款封装系统 Table 的自用的Flutter 表格组件

## 安装

```shell
flutter pub add flutter_app_table
```

## 使用

导入库

```dart
import 'package:flutter_app_table/flutter_app_table.dart';
```

### AppTable

```dart
Widget build(BuildContext context) {
    return AppTable(
        columnCount: 3, // 设置列(必须)
    );
}
```

#### AppTable 具体属性说明

| 字段                 | 类型                         | 说明                 |
| -------------------- | ---------------------------- | -------------------- |
| columnCount          | int                          | 设置表格列数【必须】 |
| rowCount             | int                          | 设置表格行数         |
| defaultColumnWidth   | double                       | 设置默认每一列的宽度 |
| rowBuilder           | AppTableRowBuilder           | 构建表格行内容       |
| headerBuilder        | AppTableColumnBuilder        | 构建表头的内容       |
| columnWidthBuilder   | AppTableColumnWidthBuilder   | 自定每一列的宽度     |
| headerDecoration     | Decoration                   | 表头的外观           |
| rowDecorationBuilder | AppTableRowDecorationBuilder | 每一行的外观设置     |
| border               | TableBorder                  | 表格边框             |
| controller           | AppTableController           | 表格数据源控制器     |

#### AppTableCell 属性说明

| 字段            | 类型              | 说明                       |
| --------------- | ----------------- | -------------------------- |
| builder         | WidgetBuilder     | 绘制Cell组件               |
| height          | double            | 单元格的高度默认40         |
| backgroundColor | Color             | 单元格背景颜色默认白色     |
| selectRowColor  | Color             | 单元格选中时的背景颜色     |
| alignment       | AlignmentGeometry | 布局方式 默认居中          |
| padding         | EdgeInsets        | 设置单元格的内边距默认为 0 |

##### 工厂方法

空的

```dart
AppTableCell.empty()
```

文本展示

```dart
AppTableCell.text({
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
})
```

可编辑

```dart
AppTableCell.textEdit({
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
})
```

