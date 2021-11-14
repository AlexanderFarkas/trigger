import 'package:flutter/material.dart';
import 'package:trigger/trigger.dart';
import 'package:trigger/validators.dart';

class SignUpFormNotifier extends ChangeNotifier with ValidatorMixin {
  ReproducingFieldTrigger<String> emailApiErrorTg;
  FormBoolTrigger turnOffValidationTg;

  bool isSubmitting = false;

  SignUpFormNotifier({
    this.emailApiErrorTg = const ReproducingFieldTrigger.disabled(),
    this.turnOffValidationTg = const FormBoolTrigger.disabled(),
  });

  void turnOffValidation() {
    turnOffValidationTg = FormBoolTrigger();
    notifyListeners();
  }

  Future<void> submitForm() async {
    isSubmitting = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    emailApiErrorTg = ReproducingFieldTrigger("Email already exists");
    isSubmitting = false;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    return validate(email)
        .notNull(error: "WTF")
        .endIf((v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'email'))
        .isValidatedBy<String>(emailApiErrorTg, errorBuilder: (error) => error)
        .isEmail()();
  }

  String? validatePassword(String? password) {
    return validate(password!) // Example without notNull
        .endIf((v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'password'))
        .minLength(8)();
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    return validate(confirmedPassword)
        .notNull(error: "WTF")
        .endIf((v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'confirm-password'))
        .equals(password, error: "Passwords should be equal")();
  }
}
