import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valform/valform.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, LoginFormState> {
  SignUpFormBloc() : super(LoginFormState.initialState()) {
    on<InvalidateSignUpFormEvent>((event, emit) {
      emit(state.copyWith(invalidateFormVf: VfExpell()));
    });
    on<SubmitSignUpFormEvent>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      print("Submitting form...");
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(
        isSubmitting: false,
        invalidateFormVf: VfExpell.sealed(),
        emailApiErrorVf: VfStrictReproduce("Email already exists"),
      ));
    });
  }
}
