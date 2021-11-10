import 'package:example/bloc/sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/sign_up_form.dart';
import 'common/my_app.dart';

class BlocForm extends StatefulWidget {
  const BlocForm({Key? key}) : super(key: key);

  @override
  State<BlocForm> createState() => _BlocFormState();
}

class _BlocFormState extends State<BlocForm> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpFormBloc(),
      child: BlocConsumer<SignUpFormBloc, SignUpFormState>(
        listener: (context, state) {
          if (state.anyTriggerEnabled()) {
            /// Bloc listener is triggered earlier than builder.
            /// If we did this without [addPostFrameCallback],
            /// widgets wouldn't have an actual version of validator functions
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              _formKey.currentState?.validate();
            });
          }
        },
        builder: (context, state) => SignUpForm(
          formKey: _formKey,
          didValidationTurnOff: () => context.read<SignUpFormBloc>().add(TurnOffValidationSignUpFormEvent()),
          onSubmit: () => context.read<SignUpFormBloc>().add(SubmitSignUpFormEvent()),
          isSubmitting: state.isSubmitting,
          validateConfirmedPassword: state.validateConfirmedPassword,
          validatePassword: state.validatePassword,
          validateEmail: state.validateEmail,
        ),
      ),
    );
  }
}
