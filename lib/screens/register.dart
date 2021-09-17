import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/widgets/button/custom_button.dart';
import 'package:flutterfirebasecrud/widgets/button/sign_or_signup_toogle.dart';
import 'package:flutterfirebasecrud/widgets/icon/social_login_icon.dart';
import 'package:flutterfirebasecrud/widgets/textfield/custom_textfield.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  final changeToggle;
  RegisterPage({Key? key, this.changeToggle}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  String? _name;
  bool? _nameError;
  String? _email;
  bool? _emailError;
  String? _password;
  bool? _passwordError;
  bool loading = false;
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  final _formKey = GlobalKey<FormState>();

  _validateName(String value) {
    value.trim();
    if (value == null || value.isEmpty) {
      setState(() {
        _nameError = true;
      });
      return 'Lütfen isminizi giriniz';
    } else if (double.tryParse(value) != null) {
      setState(() {
        _nameError = true;
      });
      return 'Sadece karakter geçerlidir';
    } else {
      setState(() {
        _nameError = false;
      });
      return null;
    }
  }

  _validatePassword(String value) {
    if (value.length < 6)
      return 'Şifre 6 karakterden büyük olmalıdır';
    else
      return null;
  }

  _validateEmail(String value) {
    value.trim();
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      print(!regex.hasMatch(value));
      return 'Geçerli mail giriniz';
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    onSubmitForm() async {
      if (_formKey.currentState!.validate()) {}
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Kayıt Ol',
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
                    foregroundColor: MaterialStateProperty.all(Colors.white70),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
                child: CustomTextField(
                    name: 'İsim',
                    onChange: (val) {
                      setState(() {
                        _name = val;
                      });
                      _name!.trim();
                      if (_validateName(val) == null) {
                        setState(() {
                          _nameError = false;
                        });
                      } else {
                        setState(() {
                          _nameError = true;
                        });
                      }
                    },
                    obscureText: false,
                    hintText: 'Esat Akyıldız',
                    keyboardType: TextInputType.text,
                    validator: _validateName,
                    error: _nameError),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 25.0),
                child: CustomTextField(
                    name: 'Email',
                    onChange: (val) {
                      setState(() {
                        _email = val;
                      });
                      _email!.trim();
                      if (_validateEmail(val) == null) {
                        setState(() {
                          _emailError = false;
                        });
                      } else {
                        setState(() {
                          _emailError = true;
                        });
                      }
                    },
                    obscureText: false,
                    hintText: 'athelas33@gmail.com',
                    keyboardType: TextInputType.text,
                    validator: _validateEmail,
                    error: _emailError),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 35.0),
                child: CustomTextField(
                    name: 'Şifre',
                    showPassword: showPassword,
                    onChange: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                    obsecureSuffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? Icon(
                                Icons.visibility_outlined,
                                color: Colors.white60,
                              )
                            : Icon(Icons.visibility_off,
                                color: Colors.white60)),
                    hintText: 'Güçlü bir şifre giriniz',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: _validatePassword,
                    error: _passwordError),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CustomButton(
                  size: size,
                  loading: loading,
                  text: 'Hesap oluştur',
                  onPressed: onSubmitForm,
                ),
              ),
              SignInOrSignUpToggle(
                  text: 'Hesabınız var mı? ',
                  textButton: 'Giriş Yap',
                  changeToggle: widget.changeToggle)
            ]),
          ),
        ),
      ),
    );
  }
}
