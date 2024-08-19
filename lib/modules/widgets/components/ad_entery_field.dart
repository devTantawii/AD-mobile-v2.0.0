import 'package:abudiyab/core/constants/palette.dart';
import 'package:flutter/material.dart';

class ADEntryField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  final String? Function(String?)? validator;

  ADEntryField({
    this.labelText,
    this.hintText,
    this.showSuffixIcon = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextFormField(
          validator: validator,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined,
                    color: Palette.iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
