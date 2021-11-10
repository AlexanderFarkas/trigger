import 'package:example/change_notifier/sign_up_form_notifier.dart';
import 'package:flutter/material.dart';

import 'common/sign_up_form.dart';

class ChangeNotifierForm extends StatefulWidget {
  const ChangeNotifierForm({Key? key}) : super(key: key);

  @override
  _ChangeNotifierFormState createState() => _ChangeNotifierFormState();
}

class _ChangeNotifierFormState extends State<ChangeNotifierForm> {
  final formKey = GlobalKey<FormState>();
  late final notifier = SignUpFormNotifier()
    ..addListener(() {
      if (mounted) setState(() {});
    });

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpForm(
      formKey: formKey,
      didValidationTurnOff: notifier.turnOffValidation,
      onSubmit: notifier.submitForm,
      isSubmitting: notifier.isSubmitting,
      validateConfirmedPassword: notifier.validateConfirmedPassword,
      validatePassword: notifier.validatePassword,
      validateEmail: notifier.validateEmail,
    );
  }
}
