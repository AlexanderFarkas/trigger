import 'package:flutter/material.dart';
import 'package:trigger/trigger.dart';
import 'package:trigger/validators.dart';

class SignUpFormNotifier extends ChangeNotifier with ValidatorMixin {
  ReproducingFieldTrigger<String> emailApiErrorTrigger;
  FormBoolTrigger turnOffValidationTrigger;

  bool isSubmitting = false;

  SignUpFormNotifier({
    this.emailApiErrorTrigger = const ReproducingFieldTrigger.disabled(),
    this.turnOffValidationTrigger = const FormBoolTrigger.disabled(),
  });

  void turnOffValidation() {
    turnOffValidationTrigger = FormBoolTrigger();
    notifyListeners();
  }

  Future<void> submitForm() async {
    isSubmitting = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    emailApiErrorTrigger = ReproducingFieldTrigger("Email already exists");
    isSubmitting = false;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    final emailApiError = emailApiErrorTrigger.access(email);
    final isInvalidated = turnOffValidationTrigger.access(email, fieldId: "email");

    validate(email).notNull(error: "WTF").isEmail();

    if (isInvalidated) {
      return null;
    } else if (emailApiError != null) {
      return emailApiError;
    } else if (email != null) {
      const errorText = "Incorrect format";
      if (email.contains("@")) {
        final split = email.split("@");
        return split.length == 2 &&
                split.every((element) => !element.contains("@") & element.isNotEmpty)
            ? null
            : errorText;
      }
      return errorText;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (turnOffValidationTrigger.access(password, fieldId: "password")) {
      return null;
    } else if (password == null || password.length < 8) {
      return "Too short";
    } else {
      return null;
    }
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    if (turnOffValidationTrigger.access(password, fieldId: "password-confirm")) {
      return null;
    } else if (password != confirmedPassword) {
      return "Passwords should be equal";
    } else {
      return null;
    }
  }
}
