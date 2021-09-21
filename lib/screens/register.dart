import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/states/register_provider.dart';
import 'package:flutterfirebasecrud/widgets/button/custom_button.dart';
import 'package:flutterfirebasecrud/widgets/button/sign_or_signup_toogle.dart';
import 'package:flutterfirebasecrud/widgets/icon/social_login_icon.dart';
import 'package:flutterfirebasecrud/widgets/textfield/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';

class RegisterPage extends StatefulWidget {
  final changeToggle;
  RegisterPage({Key? key, this.changeToggle}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  String? _name;

  String? _email;

  String? _password;
  FirebaseAuth? auth;
  bool loading = false;
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController,
      _emailController,
      _passwordController,
      _passwordagainController;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    _nameController = TextEditingController();
    _nameController?.clear();
    _emailController = TextEditingController();
    _emailController?.clear();
    _passwordController = TextEditingController();
    _passwordController?.clear();
    _passwordagainController = TextEditingController();
    _passwordagainController?.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var registerprovider =
        Provider.of<RegisterProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    onSubmitForm() async {
      if (_formKey.currentState!.validate()) {
        try {
          registerprovider.handleSignUp(
              _emailController?.text, _passwordController?.text, auth!);
        } catch (e) {
          print(e.toString() + "Bir hata oluştu");
        }
      } else {
        Get.rawSnackbar(
            icon: Icon(
              Icons.remove,
              color: Colors.redAccent,
            ),
            title: "Hata",
            message: "Boş veya geçersiz değer.");
      }
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
              CustomTextFormField(
                controller: _nameController,
                placeholder: 'İsim',
                onChanged: (val) {},
                obscureText: false,
                hintText: 'örn:Esat Akyıldız',
                textInputType: TextInputType.text,
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
                  controller: _emailController,
                  placeholder: 'Email',
                  onChanged: (val) {},
                  obscureText: false,
                  hintText: 'account@gmail.com',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value?.length == 0) {
                      return "Zorunlu Alan * Email";
                    }
                  }),
              SizedBox(
                height: size.height * 0.010,
              ),
              CustomTextFormField(
                  controller: _passwordController,
                  placeholder: "Şifre",
                  onChanged: (val) {
                    setState(() {
                      _password = val;
                    });
                  },
                  suffixicon: IconButton(
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
                          : Icon(Icons.visibility_off, color: Colors.white60)),
                  hintText: 'Güçlü bir şifre giriniz',
                  textInputType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value?.length == 0) {
                      return "Zorunlu Alan * Şifre";
                    }
                  }),
              SizedBox(
                height: size.height * 0.010,
              ),
              CustomTextFormField(
                controller: _passwordagainController,
                placeholder: 'Şifre Tekrar',
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
                suffixicon: IconButton(
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
                        : Icon(Icons.visibility_off, color: Colors.white60)),
                hintText: 'Güçlü bir şifre giriniz',
                obscureText: true,
                validator: (value) {
                  if (value?.length == 0) {
                    return "Zorunlu Alan * Şifre Tekrar";
                  } else if (value != _passwordController?.text) {
                    return "Şifreler aynı değil";
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
