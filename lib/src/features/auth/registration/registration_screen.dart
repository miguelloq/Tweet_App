import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/auth/components/auth_button.dart';
import 'package:tweet_app/src/features/auth/components/auth_error_snackbar.dart';
import 'package:tweet_app/src/features/auth/components/auth_header.dart';
import 'package:validatorless/validatorless.dart';
import 'package:tweet_app/src/features/auth/registration/store/registration_store.dart';

import '../utils/validators.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final RegistrationStore registrationStore;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    registrationStore = RegistrationStore();
    autorun((_) {
      if (registrationStore.screenState == RegistrationState.error) {
        showAuthErrorSnackBar(
            context: context, message: registrationStore.errorMessage!);
      }
    });
    when((_) => registrationStore.screenState == RegistrationState.success, () {
      Navigator.pushReplacementNamed(context, 'authLogin');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeader(
                title: 'Register',
                subTitle: 'Create your account',
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('The field is obrigatory.'),
                    Validatorless.email('The field requires an email address'),
                  ]),
                  onChanged: (value) {
                    registrationStore.changeModel(registrationStore
                        .registrationModel
                        .copyWith(email: value));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: const Icon(Icons.password),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('The field is obrigatory.'),
                    Validatorless.between(
                        6, 15, 'Minimum 6 and maximum 15 characters.'),
                  ]),
                  obscureText: true,
                  onChanged: (value) {
                    registrationStore.changeModel(registrationStore
                        .registrationModel
                        .copyWith(password: value));
                  },
                ),
              ),
              Observer(
                builder: (_) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: const Icon(Icons.library_add_check_outlined),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('The field is obrigatory.'),
                      Validators.compareString(
                          input: registrationStore.registrationModel.password,
                          message:
                              'This field needs to be the same as the Password field'),
                    ]),
                    obscureText: true,
                    onChanged: (value) {
                      registrationStore.changeModel(registrationStore
                          .registrationModel
                          .copyWith(confirmPassword: value));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AuthButton(
                    labelButton: 'Create new Account',
                    onTap: () {
                      if (registrationStore.screenState !=
                              RegistrationState.loading &&
                          registrationStore.screenState !=
                              RegistrationState.success) {
                        if (_formKey.currentState!.validate()) {
                          registrationStore.registrationAction();
                        }
                      }
                    }),
              ),
              Text.rich(
                TextSpan(
                  text: "Have a account?",
                  style: const TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: ' Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, 'authLogin');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
