part of 'sign_up_form_bloc.dart';

@immutable
abstract class SignUpFormEvent {}

class InvalidateSignUpFormEvent extends SignUpFormEvent {}

class SubmitSignUpFormEvent extends SignUpFormEvent {}
