import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/home_page.dart';
import 'package:flutter_woocomerce/utlils/form_helper.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';
import '../api_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  APIServices apiServices;

  String username;
  String password;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    apiServices = APIServices();
    super.initState();
  }

  Widget _uiScreen() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 140, right: 10, left: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (!value.contains('@') || !value.endsWith('.com')) {
                          return 'Please Enter a valid Email';
                        }
                        if (value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.redAccent,
                        ),
                      ),
                      onChanged: (value) => username = value,
                    ),
                    TextFormField(
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        if (value.length < 6) {
                          return 'Password is Too Short';
                        }
                        return null;
                      },
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.redAccent,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        var validate = globalKey.currentState.validate();
                        if (!validate) {
                          return;
                        }
                        setState(() {
                          isApiCallProcess = true;
                        });
                        var response =
                            await apiServices.loginCustomer(username, password);
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (response.data != null) {
                          FormHelper.showMessage(
                              context, 'Done', 'Logged In Successfully', 'Ok',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (HomePage()),
                              ),
                            );
                          });
                        } else {

                          FormHelper.showMessage(
                              context, 'Error!!', 'Something went wrong', 'Ok',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: _uiScreen(),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
