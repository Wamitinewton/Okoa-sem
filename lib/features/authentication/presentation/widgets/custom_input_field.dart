import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_extensions.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isPassword;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int maxLine;
  final FocusNode? focusNode;

  const CustomInputField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.isPassword = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLine = 1,
    this.focusNode,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
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
              fontWeight: FontWeight.w600
            ),
            children: widget.isRequired
            ? [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: context.colors.error
                ),
              ),
            ]
            : null
          ),
        ),

        SizedBox(height: context.sizing.xs),

        Container(
          decoration: BoxDecoration(
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
            : context.colors.surfaceAlpha(0.3)
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            initialValue: widget.controller == null ? widget.initialValue : null,
            enabled: widget.enabled,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLine,
            style: context.typography.bodyL.copyWith(
              color: widget.enabled 
              ? context.colors.onSurface
              : context.colors.disabled
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.typography.bodyL.copyWith(
                color: context.colors.surfaceAlpha(0.6),
              ),
              prefixIcon: widget.prefixIcon != null
              ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizing.s
                ),
                child: widget.prefixIcon,
              )
              : null,

              suffixIcon: _buildSuffixIcon(),
              border: InputBorder.none,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.sizing.m,
                vertical: context.sizing.m
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: context.sizing.iconL + context.sizing.m,
                minHeight: context.sizing.iconL
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: context.sizing.iconL + context.sizing.m,
                minHeight: context.sizing.iconL
              ),
            ),
            onChanged: widget.onChanged,
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

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: context.colors.surfaceAlpha(0.7),
          size: context.sizing.iconM,
        ),
        onPressed: _togglePasswordVisibility,
        splashRadius: context.sizing.iconM, 
        );
      
    }

    if (widget.suffixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.sizing.s),
        child: widget.suffixIcon,
      );
    }
    return null;
  }
}