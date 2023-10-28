import 'package:disease/custom_widget/custom_button.dart';
import 'package:disease/custom_widget/custom_loading_button.dart';
import 'package:disease/custom_widget/custom_textfield.dart';
import 'package:disease/home_screen.dart';
import 'package:disease/utils/custom_function.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String userName = '';
  late String password = '';
  bool isLoading = false;
  bool isError = false;
  bool isMounted = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: _form,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFieldWidget(
                      isPassword: false,
                      textAlign: TextAlign.left,
                      obscureText: false,
                      hintText: 'Enter Mobile Number',
                      errorMsg: null,
                      validator: (value) {
                        if (!CustomFunction.isValidName(value!)) {
                          return 'Mobile Number Could not be Empty';
                        }
                        return null;
                      },
                      onChanged: (name) {
                        setState(() {
                          userName = name;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextFieldWidget(
                      isPassword: true,
                      textAlign: TextAlign.left,
                      obscureText: true,
                      hintText: "Enter Password",
                      errorMsg: null,
                      validator: (value) {
                        if (!CustomFunction.isValidPassword(value!)) {
                          return 'Password Could not be Empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    isError
                        ? const Center(
                            child: Text(
                              "Enter Correct Credential.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 12,
                    ),
                    !isLoading
                        ? CustomButton(
                            title: 'Login',
                            onPressedCallBack: () async {
                              if (_form.currentState!.validate()) {
                                if (!isMounted) return;

                                setState(() {
                                  isError = false;
                                  isLoading = true;
                                });

                                await Future.delayed(
                                    const Duration(milliseconds: 1000));

                                if (!isMounted) return;

                                setState(() {
                                  isLoading = false;
                                });

                                if (userName != '0771234567' ||
                                    password != '123456') {
                                  setState(() {
                                    isError = true;
                                  });
                                } else {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) {
                                      if (isMounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          )
                        : const CustomLoadingButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
