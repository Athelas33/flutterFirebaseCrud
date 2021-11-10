import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:flutterfirebasecrud/services/database.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/textfield/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key key}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _db = DatabaseService();
  @override
  void initState() {
    context.read<AccountProvider>().titleController = TextEditingController();
    context.read<AccountProvider>().titleController.clear();
    context.read<AccountProvider>().contentController = TextEditingController();
    context.read<AccountProvider>().contentController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              if (_formKey.currentState.validate()) {
                final user = Provider.of<User>(context, listen: false);

                await _db.createPost(
                    user.uid,
                    context.read<AccountProvider>().titleController.text,
                    context.read<AccountProvider>().contentController.text);
              } else {
                Get.rawSnackbar(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.redAccent,
                    ),
                    title: "Hata",
                    message: "Boş veya geçersiz değer.");
              }
            } catch (e) {}
          },
          child: Icon(Icons.add),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Post Ekle',
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
            child: Column(
              children: [
                CustomTextFormField(
                    controller: context.read<AccountProvider>().titleController,
                    placeholder: 'Başlık',
                    onChanged: (val) {},
                    obscureText: false,
                    hintText: 'Başlık',
                    textInputType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    ],
                    validator: (value) {
                      if (value?.length == 0) {
                        return "Zorunlu Alan * Başlık";
                      }
                    },
                    onEditingComplete: () => Focus.of(Get.context)
                        .requestFocus(context.read<AccountProvider>().fcNode1)),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Expanded(
                  child: CustomTextFormField(
                      controller:
                          context.read<AccountProvider>().contentController,
                      placeholder: 'İçerik',
                      onChanged: (val) {},
                      obscureText: false,
                      hintText: 'İçerik',
                      textInputType: TextInputType.multiline,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      validator: (value) {
                        if (value?.length == 0) {
                          return "Zorunlu Alan * İçerik";
                        }
                      },
                      minLines: 20, //Normal textInputField will be displayed
                      maxLines: 100,
                      onEditingComplete: () => Focus.of(Get.context)
                          .requestFocus(
                              context.read<AccountProvider>().fcNode1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
