import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:okoa_sem/core/config/app_extensions.dart';
import 'package:intl_phone_field/countries.dart'; 

class InternationalPhoneField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final ValueChanged<String>? onChanged;
  final String? Function(PhoneNumber?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final FocusNode? focusNode;

  const InternationalPhoneField({
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
  State<InternationalPhoneField> createState() => _InternationalPhoneFieldState();
}

class _InternationalPhoneFieldState extends State<InternationalPhoneField> {
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

  String? _validateInput(PhoneNumber? phoneNumber) {
    if (widget.validator != null) {
      final error = widget.validator!(phoneNumber);
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

        IntlPhoneField(
          controller: widget.controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          initialCountryCode: 'KE', 
          countries: [countries.firstWhere((c) => c.code == 'KE')],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          style: context.typography.bodyL.copyWith(
            color: widget.enabled
                ? context.colors.onSurface
                : context.colors.disabled,
          ),
          dropdownTextStyle: context.typography.bodyL.copyWith(
            color: widget.enabled
                ? context.colors.onSurface
                : context.colors.disabled,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? '712 345 678',
            hintStyle: context.typography.bodyL.copyWith(
              color: context.colors.surfaceAlpha(0.6),
            ),
            filled: true,
            fillColor: widget.enabled
                ? context.colors.surfaceVariant
                : context.colors.surfaceAlpha(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
              borderSide: BorderSide(
                color: _errorText != null
                    ? context.colors.error
                    : _isFocused
                        ? context.colors.primary
                        : context.colors.border,
                width: _isFocused || _errorText != null ? 2 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
              borderSide: BorderSide(
                color: _errorText != null
                    ? context.colors.error
                    : context.colors.border,
                width: _errorText != null ? 2 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
              borderSide: BorderSide(
                color: _errorText != null
                    ? context.colors.error
                    : context.colors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
              borderSide: BorderSide(
                color: context.colors.error,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
              borderSide: BorderSide(
                color: context.colors.error,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.sizing.m,
              vertical: context.sizing.m,
            ),
            counterText: '', // Hide counter
          ),
          languageCode: 'en',
          onChanged: (phone) {
            final completeNumber = phone.completeNumber;
            widget.onChanged?.call(completeNumber);
          },
          validator: _validateInput,
          flagsButtonPadding: EdgeInsets.symmetric(
            horizontal: context.sizing.s,
          ),
          dropdownIconPosition: IconPosition.trailing,
          dropdownIcon: Icon(
            Icons.arrow_drop_down,
            color: context.colors.surfaceAlpha(0.7),
            size: context.sizing.iconM,
          ),
          showDropdownIcon: true,
          disableLengthCheck: false, 
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