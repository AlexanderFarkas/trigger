part of 'sign_up_form_bloc.dart';

class SignUpFormState with TriggerMixin, ValidatorMixin {
  final ReproducingFieldTrigger<String> emailApiErrorTg;
  final FormBoolTrigger turnOffValidationTg;

  @override
  List<Trigger> get triggers => [emailApiErrorTg, turnOffValidationTg];

  final bool isSubmitting;

  SignUpFormState({
    required this.isSubmitting,
    this.emailApiErrorTg = const ReproducingFieldTrigger.disabled(),
    this.turnOffValidationTg = const FormBoolTrigger.disabled(),
  });

  factory SignUpFormState.initialState() => SignUpFormState(
        isSubmitting: false,
      );

  SignUpFormState copyWith({
    bool? isSubmitting,
    ReproducingFieldTrigger<String>? emailApiErrorTg,
    FormBoolTrigger? turnOffValidationTg,
  }) {
    return SignUpFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailApiErrorTg: emailApiErrorTg ?? this.emailApiErrorTg,
      turnOffValidationTg: turnOffValidationTg ?? this.turnOffValidationTg,
    );
  }

  String? validateEmail(String? email) {
    return validate(email)
        .notNull(error: "WTF")
        .endIfValid((v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'email'))
        .isValidatedBy<String>(emailApiErrorTg, errorBuilder: (error) => error)
        .isEmail()();
  }

  String? validatePassword(String? password) {
    return validate(password)
        .notNull(error: "WTF")
        .endIfValid((v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'password'))
        .minLength(8)();
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    return validate(confirmedPassword)
        .notNull(error: "WTF")
        .endIfValid(
            (v) => v.isNotValidatedByFormBool(turnOffValidationTg, fieldId: 'confirm-password'))
        .equals(password, error: "Passwords should be equal")();
  }
}