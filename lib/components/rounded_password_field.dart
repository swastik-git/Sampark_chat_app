import 'package:flutter/material.dart';
import 'package:sampark/components/text_field_container.dart';
import 'package:sampark/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> validator;
  final bool eye;
  final TextEditingController cont;
  final IconData icon;
  final Function ontapicon;
  const RoundedPasswordField({
    Key key,
    this.validator,
    this.cont,
    this.onChanged,
    this.ontapicon,
    this.icon ,
    this.eye = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: cont,
        obscureText: eye,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.black54,
          ),
          suffixIcon: GestureDetector(
            onTap: ontapicon,
            child: Icon(
              icon,
              color: Colors.black54,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
