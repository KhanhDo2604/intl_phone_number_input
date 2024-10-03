import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.textStyle,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textAlign,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.autofocus = false,
    this.enabled,
    this.textInputAction,
    this.readOnly = false,
    this.suffixIcon,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.contentPadding,
    this.forcegrey,
    this.suffixIconConstraints,
    this.maxLength,
    this.borderRadius,
    this.hintStyle,
    this.fillColor,
    this.onTap,
    this.cursorColor,
    this.focusNode,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.onSaved,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onEditingComplete,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final Function(String)? onChanged;
  final bool isPassword;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool autocorrect;
  final bool enableSuggestions;
  final EdgeInsetsGeometry? contentPadding;
  final Color? forcegrey;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle textStyle;
  final int? maxLength;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final VoidCallback? onTap;
  final Color? cursorColor;
  final FocusNode? focusNode;
  final EdgeInsets scrollPadding;
  final VoidCallback? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void refreshState(void Function() fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void didUpdateWidget(covariant TextFieldWidget oldWidget) {
    if (oldWidget.textStyle != widget.textStyle) {
      refreshState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: widget.textStyle,
      autofocus: widget.autofocus,
      cursorColor: widget.cursorColor ?? Colors.grey,
      cursorErrorColor: widget.cursorColor ?? Colors.grey,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      enabled: widget.enabled,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      focusNode: widget.focusNode,
      scrollPadding: widget.scrollPadding,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onSaved: (value) {
        if (widget.onSaved != null) {
          widget.onSaved!();
        }
      },
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: widget.fillColor ?? Colors.grey,
        suffixIconConstraints: widget.suffixIconConstraints ??
            const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
        suffixIcon: widget.isPassword
            ? suffixIconPassword()
            : Padding(
                padding: const EdgeInsets.only(right: 12),
                child: widget.suffixIcon,
              ),
        counterText: '',
        errorStyle: const TextStyle(
          color: Colors.transparent,
          height: 0.001,
          fontSize: 0.0,
        ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(12),
        hintStyle: widget.hintStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.forcegrey ?? Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.forcegrey ?? Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.forcegrey ?? Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.forcegrey ?? Colors.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.forcegrey ?? Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget suffixIconPassword() {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: _obscureText
          ? const Icon(Icons.visibility_rounded)
          : const Icon(Icons.visibility_off_rounded),
      onPressed: () {
        if (mounted) {
          setState(() {
            _obscureText = !_obscureText;
          });
        }
      },
    );
  }
}
