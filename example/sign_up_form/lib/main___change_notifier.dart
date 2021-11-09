import 'package:example/widgets/change_notifier_form.dart';
import 'package:example/widgets/common/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  const form = ChangeNotifierForm();
  runApp(const MyApp(form: form));
}
