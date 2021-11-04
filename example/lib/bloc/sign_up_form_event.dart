part of 'sign_up_form_bloc.dart';

@immutable
abstract class LoginFormEvent {}

class InvalidateLoginFormEvent extends LoginFormEvent {}

class SubmitLoginFormEvent extends LoginFormEvent {}
