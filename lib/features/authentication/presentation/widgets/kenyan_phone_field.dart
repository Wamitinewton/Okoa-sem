import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_extensions.dart';

class KenyanPhoneField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final FocusNode? focusNode;

  const KenyanPhoneField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.isRequired = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<KenyanPhoneField> createState() => _KenyanPhoneFieldState();
}

class _KenyanPhoneFieldState extends State<KenyanPhoneField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String? _validateInput(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _errorText = error;
      });
      return error;
    }
    setState(() {
      _errorText = null;
    });
    return null;
  }

  String _formatPhoneNumber(String input) {
    String digits = input.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.startsWith('254')) {
      digits = digits.substring(3);
    } else if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    
    if (digits.length <= 3) {
      return '0$digits';
    } else if (digits.length <= 6) {
      return '0${digits.substring(0, 3)} ${digits.substring(3)}';
    } else if (digits.length <= 9) {
      return '0${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    } else {
      digits = digits.substring(0, 9);
      return '0${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }
  }

  String _getCleanPhoneNumber(String formattedNumber) {
    String digits = formattedNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.startsWith('0')) {
      return '+254${digits.substring(1)}';
    } else if (digits.startsWith('254')) {
      return '+$digits';
    }
    return '+254$digits';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: context.typography.labelL.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
            children: widget.isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: context.colors.error,
                      ),
                    ),
                  ]
                : null,
          ),
        ),

        SizedBox(height: context.sizing.xs),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.sizing.radiusM),
            border: Border.all(
              color: _errorText != null
                  ? context.colors.error
                  : _isFocused
                      ? context.colors.primary
                      : context.colors.border,
              width: _isFocused || _errorText != null ? 2 : 1,
            ),
            color: widget.enabled
                ? context.colors.surfaceVariant
                : context.colors.surfaceAlpha(0.3),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            initialValue: widget.controller == null ? widget.initialValue : null,
            enabled: widget.enabled,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            style: context.typography.bodyL.copyWith(
              color: widget.enabled
                  ? context.colors.onSurface
                  : context.colors.disabled,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\s\+\-\(\)]')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                final formatted = _formatPhoneNumber(newValue.text);
                return TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
              }),
            ],
            decoration: InputDecoration(
              hintText: widget.hintText ?? '0712 345 678',
              hintStyle: context.typography.bodyL.copyWith(
                color: context.colors.surfaceAlpha(0.6),
              ),
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizing.m,
                  vertical: context.sizing.m,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: context.sizing.size(24),
                      height: context.sizing.size(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.sizing.radiusS),
                        border: Border.all(
                          color: context.colors.border,
                          width: 0.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(context.sizing.radiusS),
                        child: Container(
                          color: Colors.black,
                          child: Stack(
                            children: [
                              // Green section
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: context.sizing.size(5.3),
                                child: Container(color: const Color(0xFF006600)),
                              ),
                              // White section
                              Positioned(
                                top: context.sizing.size(5.3),
                                left: 0,
                                right: 0,
                                height: context.sizing.size(5.3),
                                child: Container(color: Colors.white),
                              ),
                              // Red section
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: context.sizing.size(5.3),
                                child: Container(color: const Color(0xFFCC0000)),
                              ),
                              // Shield overlay
                              Center(
                                child: Container(
                                  width: context.sizing.size(10),
                                  height: context.sizing.size(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF006600),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.shield_outlined,
                                    size: context.sizing.size(6),
                                    color: const Color(0xFF006600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.sizing.s),
                    Text(
                      '+254',
                      style: context.typography.bodyL.copyWith(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: context.sizing.xs),
                    Container(
                      width: 1,
                      height: context.sizing.size(20),
                      color: context.colors.border,
                    ),
                  ],
                ),
              ),
              border: InputBorder.none,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.sizing.m,
                vertical: context.sizing.m,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: context.sizing.size(120),
                minHeight: context.sizing.iconL,
              ),
            ),
            onChanged: (value) {
              final cleanNumber = _getCleanPhoneNumber(value);
              widget.onChanged?.call(cleanNumber);
            },
            validator: _validateInput,
          ),
        ),

        if (_errorText != null) ...[
          SizedBox(height: context.sizing.xs),
          Text(
            _errorText!,
            style: context.typography.bodyS.copyWith(
              color: context.colors.error,
            ),
          ),
        ],
      ],
    );
  }
} 