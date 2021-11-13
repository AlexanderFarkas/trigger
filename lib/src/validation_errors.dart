class ValidationErrors {
  static ValidationErrors _instance = ValidationErrors._();
  static ValidationErrors get instance => _instance;
  static set instance(ValidationErrors? value) {
    _instance = value ?? ValidationErrors._();
  }

  ValidationErrors._();
  String minLength(int minimumLength) => "Minimum length: $minimumLength";
  String maxLength(int maximumLength) => "Maximum length: $maximumLength";
  String email() => "Email is not valid";
  String defaultError() => "Something went wrong";
}
