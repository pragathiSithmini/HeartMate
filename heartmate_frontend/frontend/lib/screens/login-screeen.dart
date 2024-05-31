// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heartmate_frontend/screens/home_screen.dart';
import 'package:heartmate_frontend/screens/create-account-screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
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
          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'HeartMate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                padding: EdgeInsets.symmetric(
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
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
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
                          color: kBlue),
                      child: TextButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          _formKey.currentState!.save();

                          final url = 'https://heart-mate.herokuapp.com//login';

                          Map userInfo = {};
                          userInfo["email"] = _email;
                          userInfo["password"] = _password;

                          final response = await http.post(Uri.parse(url),
                              body: json.encode({"userInfo": userInfo}));

                          var decoded = json.decode(response.body);

                          if (decoded["result"] == "success") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Menu(
                                  userName: decoded['name'],
                                  userId: decoded['id'],
                                  age: decoded['age'], 
                                  gender: decoded['gender'],
                                ),
                              ),
                            );
                          } else {
                            confirm(context);
                          }
                        },
                        child: Text(
                          'Log In',
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CreateNewAccount();
                      },
                    ),
                  );
                },
                child: Container(
                  child: const Text(
                    'Create New Account',
                    style: kBodyText,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: kWhite),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void confirm(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("ERROR!"),
      content: Text("Inocorrect email or passwaord."),
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
