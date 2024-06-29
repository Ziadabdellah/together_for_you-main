import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/functions/email_validator.dart';
import 'package:together_for_you/features/Business/Auth/login/view/BusnissLogin.dart';

import 'package:together_for_you/features/Business/Auth/signup/stateManagement/auth_cubit.dart';
import 'package:together_for_you/features/Business/Auth/signup/stateManagement/auth_states.dart';
import 'package:together_for_you/features/Business/Auth/signup/view/Sendverif.dart';

class BusnissSignup extends StatefulWidget {
  const BusnissSignup({super.key});

  @override
  State<BusnissSignup> createState() => _BusnissSignupState();
}

class _BusnissSignupState extends State<BusnissSignup> {
  List<String> service = [
    'Nurse',
    'Delivery',
    'Driver',
    'Cleaner',
  ];
  List<String> gender = [
    'Male ',
    'female',
  ];
  String? servicetype;
  String? Gender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool isVisable = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<BusnissSignUpCupit, BusnissSignupstates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FicationScreenBusniss()),
          );
          print('Donnnneeeeeeee');
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
          return const BusnissLogin();
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
                        'assets/Screenshot_2023-12-29_223425-removebg-preview.png'),
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
                              // labelStyle: getBodyStyle(),
                              hintText: 'Enter Your name  ',
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
                        //---------------------
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
                        //-----------
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
                        //-------------------------------------
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
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Confirm Password',style: TextStyle(color: Colors.grey)),
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
                            controller: _passwordController2,
                            validator: (value) {
                              if (value!.isEmpty &&
                                  _passwordController1 !=
                                      _passwordController2)
                                return 'youre two password arent the same';
                              return null;
                            },
                          ),
                        ),
            
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                              // labelStyle: getBodyStyle(),
                              hintText: 'Enter Your Phone Number ',
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: DropdownButtonFormField<String>(
                            value: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                                print(Gender);
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
                              hintText: 'Select your Gender',hintStyle: const TextStyle(color: Color.fromARGB(255, 173, 173, 173))
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
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                              // labelStyle: getBodyStyle(),
                              hintText: 'Enter Your age ',
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _addressController,
                             decoration: InputDecoration(
                          filled: true,
                    fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              label: const Text('Address',style: TextStyle(color: Colors.grey)),
                              // labelStyle: getBodyStyle(),
                              hintText: 'Enter Your Address  ',
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: DropdownButtonFormField<String>(
                            value: servicetype,
                            onChanged: (value) {
                              setState(() {
                                servicetype = value;
                                print(servicetype);
                              });
                            },
                            items: service.map<DropdownMenuItem<String>>(
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
                              hintText: 'Select your service',hintStyle: const TextStyle(color: Color.fromARGB(255, 173, 173, 173))
                              
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select your service';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text('Service:', style: getSmallStyle()),
                        //           ListTile(
                        //             title: Text('Nurse',
                        //                 style: getBodyStyle(fontSize: 15)),
                        //             leading: Radio<int>(
                        //               value: 1,
                        //               groupValue: service,
                        //               activeColor: Colors
                        //                   .blue, // Change the active radio button color here
                        //               fillColor: MaterialStateProperty.all(Colors
                        //                   .blue), // Change the fill color when selected
                        //               splashRadius:
                        //                   20, // Change the splash radius when clicked
                        //               onChanged: (int? value) {
                        //                 setState(() {
                        //                   service = value!;
                        //                   // gendertype = 'male';
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //           ListTile(
                        //             title: Text(
                        //               'Delivery',
                        //               style: getBodyStyle(fontSize: 15),
                        //             ),
                        //             leading: Radio<int>(
                        //               value: 2,
                        //               groupValue: service,
                        //               activeColor: Colors
                        //                   .blue, // Change the active radio button color here
                        //               fillColor: MaterialStateProperty.all(Colors
                        //                   .blue), // Change the fill color when selected
                        //               splashRadius:
                        //                   25, // Change the splash radius when clicked
                        //               onChanged: (int? value) {
                        //                 setState(() {
                        //                   service = value!;
                        //                   //   gendertype = 'female';
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Gap(10),
                        //           ListTile(
                        //             title: Text('Driver',
                        //                 style: getBodyStyle(fontSize: 15)),
                        //             leading: Radio<int>(
                        //               value: 3,
                        //               groupValue: service,
                        //               activeColor: Colors
                        //                   .blue, // Change the active radio button color here
                        //               fillColor: MaterialStateProperty.all(Colors
                        //                   .blue), // Change the fill color when selected
                        //               splashRadius:
                        //                   20, // Change the splash radius when clicked
                        //               onChanged: (int? value) {
                        //                 setState(() {
                        //                   service = value!;
                        //                   // gendertype = 'male';
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //           ListTile(
                        //             title: Text(
                        //               'Cleaner',
                        //               style: getBodyStyle(fontSize: 15),
                        //             ),
                        //             leading: Radio<int>(
                        //               value: 4,
                        //               groupValue: service,
                        //               activeColor: Colors
                        //                   .blue, // Change the active radio button color here
                        //               fillColor: MaterialStateProperty.all(Colors
                        //                   .blue), // Change the fill color when selected
                        //               splashRadius:
                        //                   25, // Change the splash radius when clicked
                        //               onChanged: (int? value) {
                        //                 setState(() {
                        //                   service = value!;
                        //                   //   gendertype = 'female';
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ,const Gap(10)
                        ,
                        MaterialButton(
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            height: 50,
            color: Colors.blue[200],
            textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // if (service == 1) {
                              //   setState(() {
                              //     servicetype = 'nurse';
                              //   });
                              // } else if (service == 2) {
                              //   setState(() {
                              //     servicetype = 'delivery';
                              //   });
                              // } else if (service == 3) {
                              //   setState(() {
                              //     servicetype = 'driver';
                              //   });
                              // } else {
                              //   setState(() {
                              //     servicetype = 'cleaner';
                              //   });
                              // }
                              print(servicetype);
                              context
                                  .read<BusnissSignUpCupit>()
                                  .regestirAdmin(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      age: _ageController.text,
                                      gender: Gender.toString(),
                                      Address: _addressController.text,
                                      password: _passwordController1.text,
                                      phone: _phoneController.text,
                                      service: servicetype.toString());
                              //----------------------
                            }
                          },
                          child: const Text(
                            'Register',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.normal),
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
                                        // decoration: BoxDecoration(color: Colors.blue),
                                        child: Image.network(
                                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                                            fit: BoxFit.cover)),
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
