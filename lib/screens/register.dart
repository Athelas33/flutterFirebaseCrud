import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:flutterfirebasecrud/services/auth.dart';
import 'package:flutterfirebasecrud/shared/loading.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/button/custom_button.dart';
import 'package:flutterfirebasecrud/widgets/button/sign_or_signup_toogle.dart';
import 'package:flutterfirebasecrud/widgets/icon/social_login_icon.dart';
import 'package:flutterfirebasecrud/widgets/textfield/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class RegisterPage extends StatefulWidget {
  final changeToggle;
  RegisterPage({Key key, this.changeToggle}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  String _name;

  String _email;

  String _password;

  bool loading = false;
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  @override
  void initState() {
    context.read<AccountProvider>().nameController = TextEditingController();
    context.read<AccountProvider>().nameController?.clear();
    context.read<AccountProvider>().emailController = TextEditingController();
    context.read<AccountProvider>().emailController?.clear();
    context.read<AccountProvider>().passwordController =
        TextEditingController();
    context.read<AccountProvider>().passwordController?.clear();
    context.read<AccountProvider>().passwordagainController =
        TextEditingController();
    context.read<AccountProvider>().passwordagainController?.clear();
    context.read<AccountProvider>().fcNode1 = FocusNode();
    context.read<AccountProvider>().fcNode2 = FocusNode();
    context.read<AccountProvider>().fcNode3 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    /*  context.read<AccountProvider>().nameController?.dispose();
    context.read<AccountProvider>().emailController?.dispose();
    context.read<AccountProvider>().passwordController?.clear();
    context.read<AccountProvider>().passwordagainController?.dispose(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var accountprovider = Provider.of<AccountProvider>(context, listen: false);

    onSubmitForm() async {
      if (_formKey.currentState.validate()) {
        try {
          _authService.handleSignUp(
            context.read<AccountProvider>().emailController?.text,
            context.read<AccountProvider>().passwordController?.text,
            context.read<AccountProvider>().nameController?.text,
          );
        } catch (e) {
          print(e.toString() + "Bir hata olu??tu");
        }
      } else {
        Get.rawSnackbar(
            icon: Icon(
              Icons.remove,
              color: Colors.redAccent,
            ),
            title: "Hata",
            message: "Bo?? veya ge??ersiz de??er.");
      }
    }

    return Consumer<AccountProvider>(
        builder: (context, value, _) => !value.loading
            ? Loading()
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                    AppBar().preferredSize.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: AppBar(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Kay??t Ol',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.height * 0.024,
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
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white70),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.black87, width: 1)))),
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
                                controller: context
                                    .read<AccountProvider>()
                                    .nameController,
                                placeholder: '??sim',
                                onChanged: (val) {},
                                obscureText: false,
                                hintText: '??rn:Esat Aky??ld??z',
                                textInputType: TextInputType.text,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z]')),
                                ],
                                validator: (value) {
                                  if (value?.length == 0) {
                                    return "Zorunlu Alan * Kullan??c?? Ad??";
                                  }
                                },
                                onEditingComplete: () => Focus.of(Get.context)
                                    .requestFocus(context
                                        .read<AccountProvider>()
                                        .fcNode1)),
                            SizedBox(
                              height: size.height * 0.010,
                            ),
                            CustomTextFormField(
                              controller: context
                                  .read<AccountProvider>()
                                  .emailController,
                              placeholder: 'Email',
                              focusNode:
                                  context.read<AccountProvider>().fcNode1,
                              onChanged: (val) {},
                              obscureText: false,
                              hintText: 'account@gmail.com',
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value?.length == 0) {
                                  return "Zorunlu Alan * Email";
                                }
                                if (!EmailValidator.validate(value)) {
                                  return "L??tfen ge??erli bir email giriniz";
                                }
                              },
                              onEditingComplete: () =>
                                  Focus.of(Get.context).requestFocus(
                                context.read<AccountProvider>().fcNode2,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.010,
                            ),
                            CustomTextFormField(
                              controller: context
                                  .read<AccountProvider>()
                                  .passwordController,
                              placeholder: "??ifre",
                              focusNode:
                                  context.read<AccountProvider>().fcNode2,
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
                                      : Icon(Icons.visibility_off,
                                          color: Colors.white60)),
                              hintText: 'G????l?? bir ??ifre giriniz',
                              textInputType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value?.length == 0) {
                                  return "Zorunlu Alan * ??ifre";
                                }
                              },
                              onEditingComplete: () => Focus.of(Get.context)
                                  .requestFocus(
                                      context.read<AccountProvider>().fcNode3),
                            ),
                            SizedBox(
                              height: size.height * 0.010,
                            ),
                            CustomTextFormField(
                              controller: context
                                  .read<AccountProvider>()
                                  .passwordagainController,
                              focusNode:
                                  context.read<AccountProvider>().fcNode3,
                              placeholder: '??ifre Tekrar',
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
                                      : Icon(Icons.visibility_off,
                                          color: Colors.white60)),
                              hintText: 'G????l?? bir ??ifre giriniz',
                              obscureText: true,
                              validator: (value) {
                                if (value?.length == 0) {
                                  return "Zorunlu Alan * ??ifre Tekrar";
                                } else if (value !=
                                    context
                                        .read<AccountProvider>()
                                        .passwordController
                                        ?.text) {
                                  return "??ifreler ayn?? de??il";
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
                                text: 'Hesap olu??tur',
                                onPressed: onSubmitForm,
                              ),
                            ),
                            SignInOrSignUpToggle(
                                text: 'Hesab??n??z var m??? ',
                                textButton: 'Giri?? Yap',
                                changeToggle: widget.changeToggle)
                          ]),
                    ),
                  ),
                ),
              ));
  }
}
