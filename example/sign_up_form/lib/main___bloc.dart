import 'package:example/widgets/bloc_form.dart';
import 'package:example/widgets/common/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  const form = BlocForm();
  runApp(const MyApp(form: form));
}
