import 'dart:developer';

import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:casauth/result.dart';
import 'package:casauth/utils.dart';
import 'package:casauth_demo/utils/cacheimage.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool autoLogin = true;
  int codeSentDelay = 0;
  AccountType accountType = AccountType.username;
  final verfiyCodeController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    verfiyCodeController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget buildSendCode() {
    return TextButton(
      onPressed: () async {
        AuthResult resp;
        switch (accountType) {
          case AccountType.email:
            resp = await AuthClient.sendCode(
              emailController.text,
              type: accountType,
            );
            break;

          case AccountType.phone:
            resp = await AuthClient.sendCode(
              phoneController.text,
              type: accountType,
            );
            break;

          default:
            return;
        }

        log("send code resp: ${resp.status}, ${resp.message}");
        if (resp.status == "error") {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("send code failed: ${resp.message}")),
          );
        } else {
          setState(() {
            codeSentDelay = 60;
          });
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("send code success")),
          );
          () async {
            while (codeSentDelay > 0) {
              await Future.delayed(const Duration(seconds: 1));
              if (!mounted) {
                return;
              }
              setState(() {
                codeSentDelay--;
              });
            }
          }();
        }
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
        child: Text('Get Code'),
      ),
    );
  }

  void onSignupPressed() async {
    if (!mounted) return;

    String verifyCode = verfiyCodeController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    try {
      AuthResult resp;
      switch (accountType) {
        case AccountType.username:
          resp = await AuthClient.registerByUserName(username, password);
          break;
        case AccountType.email:
          if (password.isEmpty) {
            password = "a$verifyCode";
            passwordController.text = password;
          }
          resp = await AuthClient.registerByEmail(
            email,
            verifyCode,
            username: username,
            password: password,
          );
          break;
        case AccountType.phone:
          if (password.isEmpty) {
            password = "a$verifyCode";
            passwordController.text = password;
          }
          resp = await AuthClient.registerByPhone(
            phone,
            verifyCode,
            username: username,
            password: password,
          );
          break;
      }

      if (resp.status == "error") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "signup failed, error: ${resp.message}, body: ${resp.jsonBody}"),
          ),
        );
      } else {
        var resp = await AuthClient.loginByUserName(username, password);

        if (resp.status == "error") {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Signup Success"),
            ),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Signup and Login Success"),
            ),
          );
        }

        if (!mounted) return;
        Navigator.pop(context, resp.jsonBody);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // logo
            Container(
              height: 150.0,
              width: 190.0,
              padding: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: cachedImage(CASAuth.config.logo),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(10),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Account Type',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  contentPadding: const EdgeInsets.all(10),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  value: accountType,
                  underline: Container(),
                  hint: const Text("Account Type"),
                  onChanged: (value) => setState(() {
                    accountType = value as AccountType;
                  }),
                  items: const <DropdownMenuItem>[
                    DropdownMenuItem(
                      value: AccountType.username,
                      child: Text("Username"),
                    ),
                    DropdownMenuItem(
                      value: AccountType.email,
                      child: Text("Email"),
                    ),
                    DropdownMenuItem(
                      value: AccountType.phone,
                      child: Text("Mobile Phone"),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter valid username'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
              ),
            ),

            accountType == AccountType.phone
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: false,
                      controller: phoneController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number'),
                    ),
                  )
                : Container(),

            accountType == AccountType.email
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: false,
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter your email'),
                    ),
                  )
                : Container(),

            accountType.index > 0
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      // alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: codeSentDelay > 0
                                ? TextButton(
                                    onPressed: null,
                                    child: Text("$codeSentDelay s"),
                                  )
                                : buildSendCode(),
                            hintText: "Enter the verification code",
                          ),
                          controller: verfiyCodeController,
                        ),
                      ],
                    ),
                  )
                : Container(),

            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("auto login after signup"),
                  Checkbox(
                    value: autoLogin,
                    onChanged: (v) => setState(() => autoLogin = v!),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => onSignupPressed(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
