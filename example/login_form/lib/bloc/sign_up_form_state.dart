part of 'sign_up_form_bloc.dart';

class LoginFormState with BooleanValformMixin {
  final VfStrictReproduce<String> emailApiErrorVf;
  final VfExpell invalidateFormVf;

  @override
  List<MultiValform> get valforms => [emailApiErrorVf, invalidateFormVf];

  final bool isSubmitting;

  LoginFormState({
    required this.isSubmitting,
    required this.emailApiErrorVf,
    required this.invalidateFormVf,
  });

  factory LoginFormState.initialState() => LoginFormState(
        isSubmitting: false,
        emailApiErrorVf: VfStrictReproduce.sealed(),
        invalidateFormVf: VfExpell.sealed(),
      );

  LoginFormState copyWith({
    bool? isSubmitting,
    VfStrictReproduce<String>? emailApiErrorVf,
    VfExpell? invalidateFormVf,
  }) {
    return LoginFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailApiErrorVf: emailApiErrorVf ?? this.emailApiErrorVf,
      invalidateFormVf: invalidateFormVf ?? this.invalidateFormVf,
    );
  }

  String? validateEmail(String? email) {
    const validationId = "email";
    final emailApiError = emailApiErrorVf.access(email, ownerId: validationId);
    final isInvalidated = invalidateFormVf.access(email, ownerId: validationId);

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
    if (invalidateFormVf.access(password, ownerId: "password")) {
      return null;
    } else if (password == null || password.length < 8) {
      return "Too short";
    } else {
      return null;
    }
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    if (invalidateFormVf.access(password, ownerId: "password-confirm")) {
      return null;
    } else if (password != confirmedPassword) {
      return "Passwords should be equal";
    } else {
      return null;
    }
  }
}
