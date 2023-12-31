import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

Widget textbox(
  controller,
  String text,
  String labal,
  String hint,
) {
  return TextFormField(
      controller: controller,
      validator: RequiredValidator(errorText: text),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hint,
        labelText: labal,
      ));
}

Widget boxadmin(controller, String text, String labal, String hint) {
  return Center(
    // ignore: sized_box_for_whitespace
    child: Container(
      width: 300,
      child: TextFormField(
        controller: controller,
        validator: RequiredValidator(errorText: text),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(hintText: hint, labelText: labal),
      ),
    ),
  );
}

Widget passbox(controller, String text, String labal, String hint) {
  return TextFormField(
    controller: controller,
    validator: RequiredValidator(errorText: text),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(hintText: hint, labelText: labal),
    obscureText: true, // เพิ่มบรรทัดนี้เพื่อปิดการมองเห็นรหัสผ่าน
  );
}

Widget telnotbox(
  controller,
  String text,
  String labal,
  String hint,
) {
  return TextFormField(
    controller: controller,
    validator: RequiredValidator(errorText: text),
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ],
    maxLength: 10,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      hintText: hint,
      labelText: labal,
    ),
  );
}
