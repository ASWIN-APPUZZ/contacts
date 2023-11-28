import 'package:contacts_app/src/controller/auth_cubit/cubit/auth_cubit.dart';
import 'package:contacts_app/src/core/common_widget/app_button.dart';
import 'package:contacts_app/src/core/constants/strings.dart';
import 'package:contacts_app/src/core/helpers/validation_helper.dart';
import 'package:contacts_app/src/core/storage/theme/app_text_theme.dart';
import 'package:contacts_app/src/views/widgets/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.email)),
                          validator: ValidationHelpers.validateEmail),

                      const SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.password)),
                        validator: ValidationHelpers.isValidPassword,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthStateAuthenticated) {
                                  // TODO: Implement the logic
                                  return;
                                }
                                if (state is AuthStateUnAuthenticated) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(Strings.error),
                                            content: Text(state.error),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(Strings.ok))
                                            ],
                                          ));
                                }
                              },
                              child: BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthStateLoading) {
                                    return const CircularProgressIndicator();
                                  }
                                  return AppButton(
                                    buttonTitle: Strings.login,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;

                                        context
                                            .read<AuthCubit>()
                                            .login(email, password);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                              },
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: Strings.newUser,
                                  style: AppTextTheme.bodyTextStyle
                                      .copyWith(color: Colors.blue.shade900),
                                ),
                                TextSpan(
                                  text: Strings.signup,
                                  style: AppTextTheme.bodyTextStyle
                                      .copyWith(color: Colors.blue.shade900),
                                )
                              ])),
                            )
                          ],
                        ),
                      )
                      // TextFormField(
                      //   decoration: InputDecoration(label: Text('Email')),
                      // )
                    ],
                  ),
                ))),
      ),
    );
  }
}