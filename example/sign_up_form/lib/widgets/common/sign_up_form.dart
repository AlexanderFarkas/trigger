import 'package:flutter/material.dart';
import 'package:trigger/trigger.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;
  final String? Function(String? confirmedPassword, String? password) validateConfirmedPassword;
  final bool isSubmitting;

  final VoidCallback onSubmit;
  final VoidCallback onInvalidate;

  const SignUpForm({
    Key? key,
    required this.formKey,
    required this.validateEmail,
    required this.validatePassword,
    required this.validateConfirmedPassword,
    required this.onSubmit,
    required this.onInvalidate,
    required this.isSubmitting,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _passwordController = TextEditingController();

  Widget get separator => const SizedBox(height: 20);

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Email"),
                  validator: widget.validateEmail,
                ),
                separator,
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password"),
                  validator: widget.validatePassword,
                ),
                separator,
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Confirm Password"),
                  validator: (confirmed) =>
                      widget.validateConfirmedPassword(confirmed, _passwordController.text),
                ),
                separator,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onInvalidate,
                        child: const Text("Invalidate"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            widget.onSubmit();
                          }
                        },
                        child: widget.isSubmitting
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
      );
}
