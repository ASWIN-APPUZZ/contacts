import 'package:contacts_app/src/controller/auth_cubit/cubit/auth_cubit.dart';
import 'package:contacts_app/src/core/common_widget/app_button.dart';
import 'package:contacts_app/src/core/constants/strings.dart';
import 'package:contacts_app/src/core/helpers/validation_helper.dart';
import 'package:contacts_app/src/models/user_requst_model.dart';
import 'package:contacts_app/src/views/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/storage/theme/app_text_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController unameController = TextEditingController();
  TextEditingController cnfrmpwdController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                      //Name
                      TextFormField(
                          keyboardType: TextInputType.name,
                          controller: unameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.name)),
                          validator: ValidationHelpers.validateName),

                      const SizedBox(
                        height: 20,
                      ),

                      // Email
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.email)),
                          validator: ValidationHelpers.validateEmail),

                      const SizedBox(
                        height: 20,
                      ),

                      //DOB
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: dobController,
                        validator: ValidationHelpers.checkISNullOrEmpty,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.dob)),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1950),
                              initialDate: DateTime.now()
                                  .subtract(const Duration(days: 18 * 365)),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 365 * 5)));
                          if (selectedDate == null) {
                            selectedDate = DateTime.now()
                                .subtract(const Duration(days: 365 * 18));
                          }
                          dobController.text =
                              selectedDate.toString().substring(0, 10);
                        },
                        // validator: ValidationHelpers.validateEmail
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Phone
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: phoneController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.phone),
                            prefix: Text('+91')),
                        validator: ValidationHelpers.validatePhone,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.newpassword)),
                        validator: ValidationHelpers.isValidPassword,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Confirm Password
                      TextFormField(
                        controller: cnfrmpwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.confirmpwd)),
                        validator: (value) {
                          if (passwordController.text != value) {
                            return 'Password dosent match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Submit Button
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is AuthStateAuthenticated) {
                              // TODO: Navigate to Login Page
                              return;
                            }
                            if (state is AuthStateUnAuthenticated) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(Strings.error),
                                        content: Text(state.error),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(Strings.ok))
                                        ],
                                      ));
                              return;
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthStateLoading) {
                              return const CircularProgressIndicator();
                            }
                            return AppButton(
                              buttonTitle: Strings.signup,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  String email = emailController.text.trim();
                                  String name = unameController.text.trim();
                                  String password = passwordController.text;
                                  String phone = phoneController.text.trim();
                                  String dob = dobController.text.trim();
                                  UserRequestModel userRequestModel =
                                      UserRequestModel(
                                          name: name,
                                          email: email,
                                          dob: dob,
                                          phoneNo: phone,
                                          password: password);
                                  context
                                      .read<AuthCubit>()
                                      .signUp(userRequestModel);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Login Page
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
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
                ))),
      ),
    );
  }
}
