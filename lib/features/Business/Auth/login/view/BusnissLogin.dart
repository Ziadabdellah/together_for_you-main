import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/functions/email_validator.dart';
import 'package:together_for_you/core/functions/route.dart';

import 'package:together_for_you/features/Business/Auth/login/stateManagement/loginCubit.dart';
import 'package:together_for_you/features/Business/Auth/login/stateManagement/loginstates.dart';
import 'package:together_for_you/features/Business/Auth/signup/view/BusnissSignup.dart';
import 'package:together_for_you/features/Business/features/BusnissNav.dart';
import 'package:together_for_you/features/on-boarding/Welcome.dart';
import 'package:together_for_you/features/person/Auth/Model/Forgot_Password/Password.dart';



class BusnissLogin extends StatefulWidget {
  const BusnissLogin({super.key});

  @override
  State<BusnissLogin> createState() => _BusnissLoginState();
}

class _BusnissLoginState extends State<BusnissLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BusnissLoginCubit, BusnissLoginstates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushWithReplacment(context, const BusnissNav());
          print('Donnnneeeeeeee');
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(appBar: AppBar(
  leading: GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return const Welcome();
        }),
      );
    },
    child: const Icon(Icons.arrow_back_ios_new_rounded),
  ),
),
       
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only( left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      
                      child: Image.asset(
                          'assets/Screenshot_2023-12-29_230255-removebg-preview.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 30),
                      child: Text(
                        'Login to your account',
                        // ignore: unnecessary_const
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    ////////////////////
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      
                          label: const Text('Email Address',style: TextStyle(color: Colors.grey)),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your email  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!emailValidate(value)) {
                            return 'the email is wrong!!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: TextFormField(
                        // style: TextStyle(color: AppColors.black),
                        obscureText: isVisable,

                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                          focusColor: Colors.transparent,
                            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      
                          label: const Text('Password',style: TextStyle(color: Colors.grey)),
                          //labelStyle: getBodyStyle(),
                          hintText: '********',

                          suffixIcon: IconButton(
                              // color: AppColors.primary,
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: Icon((isVisable)
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_rounded)),
                        ),
                        controller: _passwordController1,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'please enter your password';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                          child: const Text(
                            'Forget Password ?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    MaterialButton(
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      height: 50,
                      color: Colors.blue[200],
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<BusnissLoginCubit>().login(
                              email: _emailController.text,
                              password: _passwordController1.text);
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.black
                        , fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return const BusnissSignup();
                              }),
                            );
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ),
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
