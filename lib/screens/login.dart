import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/button/custom_button.dart';
import 'package:flutterfirebasecrud/widgets/textfield/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<AccountProvider>().auth = FirebaseAuth.instance;
    context.read<AccountProvider>().usernameController =
        TextEditingController();
    context.read<AccountProvider>().usernameController.clear();
    context.read<AccountProvider>().passwordController =
        TextEditingController();
    context.read<AccountProvider>().passwordController.clear();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Giriş Yap',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                leading: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(50, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white70),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black87, width: 1)))),
                )),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller:
                            context.read<AccountProvider>().usernameController,
                        placeholder: "Kullanıcı Adı",
                        validator: (value) {
                          if (value?.length == 0) {
                            return "Zorunlu Alan * Kullanıcı Adı";
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      CustomTextFormField(
                        controller:
                            context.read<AccountProvider>().passwordController,
                        obscureText: true,
                        placeholder: "Şifre",
                        validator: (value) {
                          if (value?.length == 0) {
                            return "Zorunlu Alan * Şifre";
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CustomButton(
                          size: size,
                          loading: context.read<AccountProvider>().loading,
                          text: 'Giriş Yap',
                          onPressed: () {
                            var accountprovider = Provider.of<AccountProvider>(
                                context,
                                listen: false);

                            try {
                              if (_formKey.currentState.validate()) {
                                accountprovider.handleSignIn(
                                    context
                                        .read<AccountProvider>()
                                        .usernameController
                                        .text,
                                    context
                                        .read<AccountProvider>()
                                        .passwordController
                                        .text,
                                    context.read<AccountProvider>().auth);
                              } else {}
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
