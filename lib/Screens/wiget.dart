import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

Widget textbox(controller, String text, String labal, String hint) {
  return TextFormField(
    controller: controller,
    validator: RequiredValidator(errorText: text),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(hintText: hint, labelText: labal),
  );
}

Widget Dropdownsex() {
  String dropdownsex;
  List listItem = ["ชาย", "หญิง"];
  return Column(
    children: [],
  );
}
