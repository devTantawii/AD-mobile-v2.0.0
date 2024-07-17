import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ADPrimPhoneTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validat;
  final TextInputType type;
  final Function()? onTap;
  final Function(String)? oFS;

  final String label;
  final IconData pIcon;
  final IconData? sIcon;
  final Function()? sOnTap;
  final bool isClickable;
  final bool auth;

  final String? hint;
  final List<TextInputFormatter>? inputFormatters;

  final double sizeText;

  ADPrimPhoneTextForm(
      {Key? key,
        required this.controller,
        this.validat,
        required this.type,
        this.onTap,
        this.oFS,
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
  State<ADPrimPhoneTextForm> createState() => _ADPrimPhoneTextFormState();
}

class _ADPrimPhoneTextFormState extends State<ADPrimPhoneTextForm> {
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
    return Container(
      width: MediaQuery.of(context).size.width*0.74,
      child: TextFormField(
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
            .bodyText2!
            .copyWith(fontSize: widget.sizeText , color: Colors.black87)
            : Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: widget.sizeText),
        // : Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: widget.auth
                      ? Colors.blueAccent.withOpacity(0.5)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: widget.auth
                      ? Colors.blueAccent
                      : Colors.blueAccent ,
                  width: 1.4)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: widget.auth
                      ? Colors.white70
                      : Theme.of(context).colorScheme.error.withOpacity(0.3),
                  width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: widget.auth
                      ? Colors.white70
                      : Theme.of(context).colorScheme.error.withOpacity(0.3),
                  width: 1.0)),
          fillColor: widget.auth ? Colors.white10 : null,
          filled: true,
          label: Text(widget.label),
          labelStyle: widget.auth
              ? TextStyle(color: Colors.grey[500])
              : Theme.of(context).textTheme.bodyText2,
          hintText: widget.hint,
          prefixIcon:
              Icon(
                widget.pIcon,
                color: widget.auth
                    ? Colors.grey[500]
                    : Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ),
          suffixIcon: widget.type == TextInputType.visiblePassword
              ? IconButton(
            onPressed: changeVisibility,
            icon: Icon(
              isShow ? Icons.visibility : Icons.visibility_off,
              color: widget.auth
                  ? Colors.grey[400]
                  : Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          )
              : null,
        ),
      ),
    );
  }
}
