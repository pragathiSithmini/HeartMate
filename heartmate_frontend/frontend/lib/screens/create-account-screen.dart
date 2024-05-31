// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _dob;
  int? _gender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scrollbar(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image1.jpg'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Colors.black54,
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400]?.withOpacity(0.4),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: kWhite,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.user,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Enter your first name',
                                  hintStyle: kBodyText,
                                ),
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'First name can not be empty';
                                  }
                                  else if (value .length < 3) {
                                    return 'First Name must be more than 2 characters';
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _firstName = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.user,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Enter your last name',
                                  hintStyle: kBodyText,
                                ),
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Last name can not be empty';
                                  }
                                  else if (value .length < 3) {
                                    return 'Last Names must be more than 2 characters';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _lastName = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'DoB (yyyy-mm-dd)',
                                  hintStyle: kBodyText,
                                ),
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Date of birth can not be empty';
                                  }

                                  if (!RegExp(
                                          r"^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$")
                                      .hasMatch(value)) {
                                    return 'DoB should be in yyyy-mm-dd format';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _dob = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.male,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Gender (Male-1/Female-0)',
                                  hintStyle: kBodyText,
                                ),
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  int? gender = int.tryParse(value!);

                                  if (value.isEmpty) {
                                    return 'Gender can not be empty';
                                  }
                                  if(gender!=0 && gender!=1){
                                    return "Must enter either 1 or 0";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _gender = int.tryParse(value!);
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.envelope,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: kBodyText,
                                ),
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Email can not be empty';
                                  }

                                  if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email Address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _email = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.lock,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: kBodyText,
                                ),
                                obscureText: true,
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Password can not be empty';
                                  }
                                  else if (value .length < 8) {
                                    return 'Password is too weak';
                                 }
                                  else {
                                    _confirmPassword = value;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.lock,
                                      size: 28,
                                      color: kWhite,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: kBodyText,
                                ),
                                obscureText: true,
                                style: kBodyText,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Password can not be empty';
                                  }
                                  if (value != _confirmPassword) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _confirmPassword = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: kBlue,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              _formKey.currentState!.save();

                              final url = 'https://heart-mate.herokuapp.com//signup';

                              Map userInfo = {};
                              userInfo["email"] = _email;
                              userInfo["password"] = _password;
                              userInfo["firstName"] = _firstName;
                              userInfo["lastName"] = _lastName;
                              userInfo["dob"] = _dob;
                              userInfo["gender"] = _gender;

                              final response = await http.post(Uri.parse(url),
                                  body: json.encode({"userInfo": userInfo}));

                              var decoded = json.decode(response.body);

                              if (decoded["result"] == "success") {
                                Navigator.pop(context);
                              } else {
                                confirm(context);
                              }
                            },
                            child: Text(
                              'Create Account',
                              style:
                                  kBodyText.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confirm(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("ERROR!"),
      content: Text("An account with this email already exists."),
      // ignore: prefer_const_literals_to_create_immutables
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Ok",
          ),
        )
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
