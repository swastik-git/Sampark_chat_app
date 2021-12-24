import 'package:flutter/material.dart';
import 'package:sampark/components/text_field_container.dart';
import 'package:sampark/constants.dart';

class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> validator;
  final TextInputType type;
  final TextEditingController cont;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.cont,
    this.validator,
    this.hintText,
    this.type,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        keyboardType: type,
        controller: cont,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black54,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
