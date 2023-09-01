import 'package:flutter/cupertino.dart';

class UserID {
  TextEditingController name;
  TextEditingController fname;
  TextEditingController address;
  TextEditingController tombon;
  TextEditingController aumphue;
  TextEditingController provinec;
  // TextEditingController numadd;
  TextEditingController telephone;
  TextEditingController line;
  TextEditingController facebook;
  TextEditingController etc;
  TextEditingController timeopen;
  TextEditingController timeclose;

  UserID(
      {required this.name,
      required this.tombon,
      required this.fname,
      required this.address,
      required this.aumphue,
      required this.provinec,
      // required this.numadd,
      required this.telephone,
      required this.line,
      required this.facebook,
      required this.etc,
      required this.timeclose,
      required this.timeopen});
}
