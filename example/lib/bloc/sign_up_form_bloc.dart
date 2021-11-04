import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valform/valform.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState.initialState()) {
    on<InvalidateLoginFormEvent>((event, emit) {
      emit(state.copyWith(invalidateFormVf: VfExpell()));
    });
    on<SubmitLoginFormEvent>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      print("Submitting form...");
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(
        isSubmitting: false,
        invalidateFormVf: VfExpell.sealed(),
        emailAlreadyExistsVf: VfReproduce(),
      ));
    });
  }
}
