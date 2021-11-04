import 'package:example/bloc/sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeArea(
        child: Scaffold(
          body: Builder(builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: LoginForm(),
            );
          }),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget get separator => const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpFormBloc(),
      child: BlocConsumer<SignUpFormBloc, LoginFormState>(
        listener: (context, state) {
          if (state.anyIsNotSealed()) {
            /// Bloc listener is triggered earlier than builder.
            /// If we did this without [addPostFrameCallback],
            /// widgets wouldn't have actual version of validator functions
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              _formKey.currentState?.validate();
            });
          }
        },
        builder: (context, state) => Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: state.validateEmail,
                  ),
                  separator,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password"),
                    validator: state.validatePassword,
                  ),
                  separator,
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Confirm Password"),
                    validator: (confirmed) =>
                        state.validateConfirmedPassword(confirmed, _passwordController.text),
                  ),
                  separator,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              context.read<SignUpFormBloc>().add(InvalidateSignUpFormEvent()),
                          child: const Text("Invalidate"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpFormBloc>().add(SubmitSignUpFormEvent());
                            }
                          },
                          child: state.isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
