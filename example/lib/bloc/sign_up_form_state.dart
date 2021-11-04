part of 'sign_up_form_bloc.dart';

class LoginFormState with BooleanValformMixin {
  final VfReproduce emailAlreadyExistsVf;
  final VfExpell invalidateFormVf;

  @override
  List<BooleanValform> get valforms => [emailAlreadyExistsVf, invalidateFormVf];

  final bool isSubmitting;

  LoginFormState({
    required this.isSubmitting,
    required this.emailAlreadyExistsVf,
    required this.invalidateFormVf,
  });

  factory LoginFormState.initialState() => LoginFormState(
        isSubmitting: false,
        emailAlreadyExistsVf: VfReproduce.sealed(),
        invalidateFormVf: VfExpell.sealed(),
      );

  LoginFormState copyWith({
    bool? isSubmitting,
    VfReproduce? emailAlreadyExistsVf,
    VfExpell? invalidateFormVf,
  }) {
    return LoginFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailAlreadyExistsVf: emailAlreadyExistsVf ?? this.emailAlreadyExistsVf,
      invalidateFormVf: invalidateFormVf ?? this.invalidateFormVf,
    );
  }

  String? validateEmail(String? email) {
    const validationId = "email";
    final isEmailAlreadyExists = emailAlreadyExistsVf.canAccess(email, owner: validationId);
    final isInvalidated = invalidateFormVf.canAccess(email, owner: validationId);

    if (isInvalidated) {
      return null;
    } else if (isEmailAlreadyExists) {
      return "Email already exists";
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
    if (invalidateFormVf.canAccess(password, owner: "password")) {
      return null;
    } else if (password == null || password.length < 8) {
      return "Too short";
    } else {
      return null;
    }
  }

  String? validateConfirmedPassword(String? confirmedPassword, String? password) {
    if (invalidateFormVf.canAccess(password, owner: "password-confirm")) {
      return null;
    } else if (password != confirmedPassword) {
      return "Passwords should be equal";
    } else {
      return null;
    }
  }
}
