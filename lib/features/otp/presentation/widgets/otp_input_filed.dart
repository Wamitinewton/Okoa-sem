import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/features/otp/presentation/widgets/otp_input_cell.dart';

class OtpInputField extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback? onCompleted;
  final bool hasError;
  final bool enabled;
  final int length;

  const OtpInputField({
    super.key,
    required this.value,
    required this.onChanged,
    this.onCompleted,
    this.hasError = false,
    this.enabled = true,
    this.length = 6,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(text: widget.value);
    
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(OtpInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.value.length),
      );
    }
  }

  void _onFocusChanged() {
    setState(() {});
  }

  void _onTextChanged(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final limitedValue = cleanedValue.length > widget.length
        ? cleanedValue.substring(0, widget.length)
        : cleanedValue;

    if (limitedValue != widget.value) {
      widget.onChanged(limitedValue);
      
      if (limitedValue.length == widget.length) {
        _focusNode.unfocus();
        widget.onCompleted?.call();
        HapticFeedback.lightImpact();
      }
    }
  }

  void _onCellTapped(int index) {
    _focusNode.requestFocus();
    
    final newPosition = index <= widget.value.length 
        ? index 
        : widget.value.length;
    
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: newPosition),
    );
  }

  int get _activeIndex {
    if (!_focusNode.hasFocus) return -1;
    
    final cursorPosition = _controller.selection.baseOffset;
    if (cursorPosition == -1) return widget.value.length;
    
    return cursorPosition.clamp(0, widget.length - 1);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.0,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  maxLength: widget.length,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  onChanged: _onTextChanged,
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 1,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  cursorColor: Colors.transparent,
                  showCursor: false,
                ),
              ),
            ),
            
            // OTP cells display
            _buildOtpCells(context),
          ],
        ),
        
        if (widget.hasError) ...[
          SizedBox(height: context.sizing.s),
          _buildErrorIndicator(context),
        ],
      ],
    );
  }

  Widget _buildOtpCells(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.sizing.xs,
            ),
            child: OtpInputCell(
              value: index < widget.value.length ? widget.value[index] : '',
              isActive: _activeIndex == index && widget.enabled,
              hasError: widget.hasError,
              isCompleted: index < widget.value.length,
              onTap: () => _onCellTapped(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorIndicator(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: context.sizing.m,
        vertical: context.sizing.xs,
      ),
      decoration: BoxDecoration(
        color: context.colors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(context.sizing.radiusS),
        border: Border.all(
          color: context.colors.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: context.sizing.iconS,
            color: context.colors.error,
          ),
          SizedBox(width: context.sizing.xs),
          Flexible(
            child: Text(
              'Invalid code. Please check and try again.',
              style: context.typography.bodyS.copyWith(
                color: context.colors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}