import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/functions/email_validator.dart';
import 'package:together_for_you/features/person/Auth/Model/Login/Login.dart';
import 'package:together_for_you/features/person/Auth/Model/Sign_Up/SendVerificat.dart';
import 'package:together_for_you/features/person/Auth/FireBase/Sing_Up/Sign_Up.dart';
import 'package:together_for_you/features/person/Auth/State_Management/State_Sign_Up/Sing_Up.dart';

class PersonSignup extends StatefulWidget {
  const PersonSignup({Key? key}) : super(key: key);

  @override
  State<PersonSignup> createState() => _PersonSignupState();
}

class _PersonSignupState extends State<PersonSignup> {
  List<String> gender = [
    'Male ',
    'female',
  ]; 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _Disabilitytype = TextEditingController();
  String? Gender;
  bool isVisable = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonSignUpCupit, PersonSignupstates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FicationScreen(
                    )),
          );
          print('Done');
        } else if (state is RegisterErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
  leading: GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return const PersonLogin();
        }),
      );
    },
    child: const Icon(Icons.arrow_back_ios_new_rounded,),
  ),
),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    child: Image.asset(
                      'assets/Screenshot_2023-12-29_221442-removebg-preview.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _nameController,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Full Name',style: TextStyle(color: Colors.grey)),
                              hintText: 'Enter Your name',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
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
                              hintText: 'Enter Your email',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!emailValidate(value)) {
                                return 'The email is wrong!!';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            obscureText: isVisable,
                            keyboardType: TextInputType.visiblePassword,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Password',style: TextStyle(color: Colors.grey)),
                              hintText: '****',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: Icon(isVisable
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off_rounded),
                              ),
                            ),
                            controller: _passwordController1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            obscureText: isVisable,
                            keyboardType: TextInputType.visiblePassword,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Confirm Password',style: TextStyle(color: Colors.grey)),
                              hintText: '****',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: Icon(isVisable
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off_rounded),
                              ),
                            ),
                            controller: _passwordController2,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  _passwordController1.text !=
                                      _passwordController2.text) {
                                return 'Your two passwords are not the same';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _phoneController,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Phone Number',style: TextStyle(color: Colors.grey)),
                              hintText: 'Enter Your Phone Number',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownButtonFormField<String>(
                            value: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                              });
                            },
                            items: gender.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                           decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              hintText: 'Select your Gender',
        hintStyle: TextStyle(color: const Color.fromARGB(255, 173, 173, 173)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select your Gender';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Age',style: TextStyle(color: Colors.grey)),
                              hintText: 'Enter Your age',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Age';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _addressController,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Address',style: TextStyle(color: Colors.grey)),
                              hintText: 'Enter Your Address',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your address';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _Disabilitytype,
                         decoration: InputDecoration(
                            filled: true,
        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Disability type',style: TextStyle(color: Colors.grey)),
                              hintText: 'Enter Your Disability',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Disability type';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Gap(10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                         child: MaterialButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              height: 50,
              color: Colors.blue[200],
              textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<PersonSignUpCupit>()
                                    .regestirPerson(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      age: _ageController.text,
                                      Disabilitytype: _Disabilitytype.text,
                                      Address: _addressController.text,
                                      password: _passwordController1.text,
                                      phone: _phoneController.text,
                                      Gender: Gender!,
                                    );
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black,fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 200,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child: Image.network(
                                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.facebook,
                                      color: Colors.blue,
                                      size: 35,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 5, left: 2),
                                      child: Icon(
                                        Icons.apple,
                                        size: 42,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
