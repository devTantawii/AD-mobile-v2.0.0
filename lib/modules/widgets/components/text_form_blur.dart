import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldBlur extends StatefulWidget {
  final String hintText;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? showPassword;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final bool? maxLengthEnforced;
  final String? errorMessage;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;

  const TextFormFieldBlur({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.showPassword = false,
    this.borderRadius,
    this.contentPadding,
    this.controller,
    this.maxLength,
    this.counterText,
    this.errorMessage,
  }) : super(key: key);

  @override
  _TextFormFieldBlurState createState() => _TextFormFieldBlurState();
}

class _TextFormFieldBlurState extends State<TextFormFieldBlur> {
  bool showPassword = true;
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: .0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white12.withOpacity(0.2),
              borderRadius: widget.borderRadius == null
                  ? BorderRadius.circular(12)
                  : widget.borderRadius),
          child: TextFormField(
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSaved: widget.onSaved,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
            obscureText: widget.showPassword!,
            decoration: InputDecoration(
              counterText: widget.counterText == null ? "" : widget.counterText,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              suffixIcon: widget.showPassword! && widget.errorMessage == null
                  ? IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )
                  : Opacity(
                      opacity: widget.errorMessage != null ? 1 : 0,
                      child: Tooltip(
                        message: "${widget.errorMessage}",
                        child: Icon(
                          Icons.info,
                          color: Colors.red,
                        ),
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(seconds: 1),
                        textStyle: TextStyle(color: Colors.red),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
              contentPadding: widget.contentPadding == null
                  ? EdgeInsets.only(top: 11, bottom: 12.5, left: 23, right: 10)
                  : widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
