import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ADPrimTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validat;
  final TextInputType type;
  final Function()? onTap;
  final Function(String)? oFS;
  final int? maxlenth;
  final String label;
  final IconData pIcon;
  final IconData? sIcon;
  final Function()? sOnTap;
  final bool isClickable;
  final bool auth;

  final String? hint;
  final List<TextInputFormatter>? inputFormatters;

  final double sizeText;

  ADPrimTextForm(
      {Key? key,
        required this.controller,
        this.validat,
        required this.type,
        this.onTap,
        this.oFS,
        this.maxlenth,
        required this.label,
        required this.pIcon,
        this.sIcon,
        this.sOnTap,
        this.auth = false,
        this.isClickable = true,
        this.hint,
        this.inputFormatters,
        this.sizeText = 14})
      : super(key: key);

  @override
  State<ADPrimTextForm> createState() => _ADPrimTextFormState();
}

class _ADPrimTextFormState extends State<ADPrimTextForm> {
  late bool isShow;
  changeVisibility() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  void initState() {
    isShow = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxlenth,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      validator: widget.validat,
      onTap: widget.onTap,
      enabled: widget.isClickable,
      onFieldSubmitted: widget.oFS,
      obscureText:
      widget.type == TextInputType.visiblePassword ? !isShow : isShow,
      keyboardType: widget.type,
      style: widget.auth
          ? Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: widget.sizeText , color: Theme.of(context).brightness==Brightness.light?Colors.black54:Color(0xffFDFDFD))
          : Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: widget.sizeText.sp,color: Theme.of(context).colorScheme.onPrimary),
      // : Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),
      decoration: InputDecoration(
        // border: Border.all(color:Theme.of(context).colorScheme.primary),
        contentPadding:  EdgeInsets.all(10.0.sp),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.auth
                    ? Colors.blueAccent.withOpacity(0.5)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.auth
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.1) ,
                width: 1.4)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.auth
                    ? Colors.white70
                    : Theme.of(context).colorScheme.error.withOpacity(0.3),
                width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: widget.auth
                    ? Colors.white70
                    : Theme.of(context).colorScheme.error.withOpacity(0.3),
                width: 1.0)),
        fillColor: widget.auth ? Theme.of(context).brightness==Brightness.light?Color(0xFFE1E6F8): Color(0xff34345E): null,
        filled: true,
        label: Text(widget.label),
        labelStyle: widget.auth
            ? TextStyle(color: Theme.of(context).brightness==Brightness.light?Colors.grey[600]:Color(0xffFDFDFD),)
            : TextStyle(color: Colors.grey[600],fontSize: 14.sp),
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.pIcon,
          color: widget.auth
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary.withOpacity(0.8),
        ),
        suffixIcon: widget.type == TextInputType.visiblePassword
            ? IconButton(
          onPressed: changeVisibility,
          icon: Icon(
            isShow ? Icons.visibility : Icons.visibility_off,
            color: widget.auth
                ? Colors.grey
                : Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ),
        )
            : null,
      ),
    );
  }

}
