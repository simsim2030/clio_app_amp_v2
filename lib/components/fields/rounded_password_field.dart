import 'package:clio_chess_app/components/fields/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData suffixicon;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.hintText = "Password",
    this.icon = Icons.lock,
    this.onChanged,
    this.suffixicon = Icons.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white70,
          ),
          suffixIcon: Icon(
            suffixicon,
            color: Colors.white70,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
