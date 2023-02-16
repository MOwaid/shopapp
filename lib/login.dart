// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shopapp/utils/CustomBorder.dart';
import 'package:shopapp/utils/CustomColors.dart';
import 'package:shopapp/utils/CustomTextStyle.dart';
import 'package:shopapp/utils/CustomUtils.dart';

import 'Models/DBHelper.dart';
import 'Pages/add_user_page.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uidController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    uidController.dispose();
    passController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  const Expanded(
                    flex: 40,
                    child: Image(
                        image: AssetImage("assets/images/ic_logo.png"),
                        color: Colors.blue,
                        height: 140,
                        alignment: Alignment.center,
                        width: 200),
                  ),
                  Expanded(
                    flex: 60,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: uidController,
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "Mobile No. or Email",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldMedium
                                    .copyWith(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            16,
                                        color: Colors.black)),
                            validator: (value) {
                              if (value == null) {
                                return "Please enter your email or mobile no.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Utils.getSizedBox(height: 20),
                          TextFormField(
                            controller: passController,
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "Password",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldMedium
                                    .copyWith(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            16,
                                        color: Colors.black)),
                            obscureText: true,
                            validator: (value) {
                              if (value == null) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Utils.getSizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue[400]!),
                              ),
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              onPressed: () {
                                userauth(
                                    uidController.text, passController.text);
                              },
                            ),
                          ),
                          Utils.getSizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(
                                "Forget Password?",
                                style: CustomTextStyle.textFormFieldBold
                                    .copyWith(color: Colors.blue, fontSize: 14),
                              ),
                            ),
                          ),
                          Utils.getSizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 40,
                                child: Container(
                                  color: Colors.grey.shade200,
                                  margin: const EdgeInsets.only(right: 16),
                                  height: 1,
                                ),
                              ),
                              Text(
                                "Or",
                                style: CustomTextStyle.textFormFieldMedium
                                    .copyWith(fontSize: 14),
                              ),
                              Expanded(
                                flex: 40,
                                child: Container(
                                  color: Colors.grey.shade200,
                                  margin: const EdgeInsets.only(left: 16),
                                  height: 1,
                                ),
                              )
                            ],
                          ),
                          Utils.getSizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors
                                    .pinkAccent, //change background color of button
                                backgroundColor: CustomColors
                                    .COLOR_FB, //change text color of button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                "FACEBOOK Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          Utils.getSizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account?",
                                style: CustomTextStyle.textFormFieldMedium
                                    .copyWith(fontSize: 14),
                              ),
                              Utils.getSizedBox(width: 4),
                              GestureDetector(
                                child: Text(
                                  "Sign Up",
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(
                                          fontSize: 14, color: Colors.blue),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return const AddUserPage();
                                  })).then((value) => setState(() {}));

                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  userauth(String uname, String upass) async {
    final bool result = await DBHelper.fuser(uname, upass);

    if (result == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context);
    }

    // ignore: use_build_context_synchronously
    // Navigator.pop(context);
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Wrong Details"),
      content: const Text("You have entered invalid user details!."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
