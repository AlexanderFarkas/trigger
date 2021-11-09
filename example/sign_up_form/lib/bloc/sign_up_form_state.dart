part of 'sign_up_form_bloc.dart';

class SignUpFormState with TriggerMixin {
  final ReproducingFieldTrigger<String> emailApiErrorTg;
  final InvalidatingFormTrigger turnOffValidationTg;

  @override
  List<Trigger> get triggers => [emailApiErrorTg, turnOffValidationTg];

  final bool isSubmitting;

  SignUpFormState({
    required this.isSubmitting,
    this.emailApiErrorTg = const ReproducingFieldTrigger.sealed(),
    this.turnOffValidationTg = const InvalidatingFormTrigger.disabled(),
  });

  factory SignUpFormState.initialState() => SignUpFormState(
        isSubmitting: false,
      );

  SignUpFormState copyWith({
    bool? isSubmitting,
    ReproducingFieldTrigger<String>? emailApiErrorTg,
    InvalidatingFormTrigger? turnOffValidationTg,
  }) {
    return SignUpFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailApiErrorTg: emailApiErrorTg ?? this.emailApiErrorTg,
      turnOffValidationTg: turnOffValidationTg ?? this.turnOffValidationTg,
    );
  }

  String? validateEmail(String? email) {
    final emailApiError = emailApiErrorTg.access(email);
    final isInvalidated = turnOffValidationTg.access(email, fieldId: "email");

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
    if (turnOffValidationTg.access(password, fieldId: "password")) {
      return null;
    } else if (password == null || password.length < 8) {
      return "Too short";
    } else {
      return null;
    }
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    if (turnOffValidationTg.access(password, fieldId: "password-confirm")) {
      return null;
    } else if (password != confirmedPassword) {
      return "Passwords should be equal";
    } else {
      return null;
    }
  }
}
