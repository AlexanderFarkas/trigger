import 'package:flutter/material.dart';
import 'package:trigger/trigger.dart';

class SignUpFormNotifier extends ChangeNotifier {
  VfReproduce<String> emailApiErrorVf;
  MultiVfExpel invalidateFormVf;

  bool isSubmitting = false;

  SignUpFormNotifier({
    this.emailApiErrorVf = const VfReproduce.sealed(),
    this.invalidateFormVf = const MultiVfExpel.sealed(),
  });

  void invalidateForm() {
    invalidateFormVf = MultiVfExpel();
    notifyListeners();
  }

  Future<void> submitForm() async {
    isSubmitting = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    emailApiErrorVf = VfReproduce("Email already exists");
    isSubmitting = false;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    final emailApiError = emailApiErrorVf.access(email);
    final isInvalidated = invalidateFormVf.access(email, fieldId: "email");

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
    if (invalidateFormVf.access(password, fieldId: "password")) {
      return null;
    } else if (password == null || password.length < 8) {
      return "Too short";
    } else {
      return null;
    }
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    if (invalidateFormVf.access(password, fieldId: "password-confirm")) {
      return null;
    } else if (password != confirmedPassword) {
      return "Passwords should be equal";
    } else {
      return null;
    }
  }
}
