import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trigger/trigger.dart';
import 'package:trigger/validators.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {

  SignUpFormBloc() : super(SignUpFormState.initialState()) {
    on<TurnOffValidationSignUpFormEvent>((event, emit) {
      emit(state.copyWith(turnOffValidationTg: FormBoolTrigger()));
    });
    on<SubmitSignUpFormEvent>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      print("Submitting form...");
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        isSubmitting: false,
        turnOffValidationTg: const FormBoolTrigger.disabled(),
        emailApiErrorTg: ReproducingFieldTrigger("Email already exists"),
      ));
    });
  }
}
