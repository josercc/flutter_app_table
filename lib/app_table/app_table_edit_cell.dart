import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 可以进行编辑的 Cell
class AppTableEditCell extends StatefulWidget {
  /// 内容文本
  final String text;

  /// text edit controller
  final TextEditingController? controller;

  /// 输入框输入文本样式
  final List<TextInputFormatter> inputFormatters;

  final TextInputType? keyboardType;

  /// 显示文本的样式
  final TextStyle textStyle;

  final ValueChanged<String?>? onSubmitted;

  const AppTableEditCell({
    Key? key,
    required this.text,
    this.controller,
    this.textStyle = const TextStyle(color: Color(0xFF333333), fontSize: 14),
    this.inputFormatters = const [],
    this.keyboardType,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<AppTableEditCell> createState() => _AppTableEditCellState();
}

class _AppTableEditCellState extends State<AppTableEditCell> {
  late TextEditingController _controller;
  bool isEditing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController.fromValue(TextEditingValue(text: widget.text));

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        isEditing = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isEditing = !isEditing;
        });
        _focusNode.requestFocus();
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: isEditing ? _buildEditCell(context) : _buildTextCell(context),
      ),
    );
  }

  /// 显示输入框
  Widget _buildEditCell(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF00AA91),
          width: isEditing ? 1 : 0,
        ),
      ),
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        readOnly: !isEditing,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.text,
          hintStyle: widget.textStyle,
        ),
        style: widget.textStyle,
        focusNode: _focusNode,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        onSubmitted: (value) {
          isEditing = !isEditing;
          setState(() {});
          widget.onSubmitted?.call(value);
        },
      ),
    );
  }

  Widget _buildTextCell(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text,
          style: const TextStyle(color: Color(0xFF333333), fontSize: 14),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.mode_edit_outlined,
          size: 12,
          color: Color(0xFF00AA91),
        ),
      ],
    );
  }
}
