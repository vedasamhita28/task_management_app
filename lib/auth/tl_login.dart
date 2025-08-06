import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/auth/providers/auth_provider.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/constants/utils.dart';
import 'package:task_management_app/widgets/appbar_widget.dart';
import 'package:task_management_app/widgets/primary_button.dart';
import 'package:task_management_app/widgets/server_key.dart';
import 'package:task_management_app/widgets/text_field.dart';

class TlLogin extends StatefulWidget {
  const TlLogin({super.key});

  @override
  State<TlLogin> createState() => _TlLoginState();
}

class _TlLoginState extends State<TlLogin> {
  final box = GetStorage();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final key = await get_server_key().server_token();
      box.write('server-key', key);
      print("UUUUUUUUUUUUUUUUUUUUUUUU");
      print(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppbarWidget(
        title: "Team Lead Log In",
        backArraw: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/login_img.png'),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryBgColor,
                  boxShadow: AppColors.cardBoxShadow,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              width: 400,
              height: 400,
              child: Form(
                key: formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "Log In",
                        style: Style.subHeadingStyle,
                      ),
                      gapH20,
                      PrimaryTextField(
                          hintText: "Enter your Email",
                          controller: emailController,
                          isRequried: true),
                      gapH20,
                      PrimaryTextField(
                        hintText: "Enter Your Password",
                        controller: passwordController,
                        isRequried: true,
                        obscureText: true,
                      ),
                      gapH20,
                      PrimaryButton(
                        text: 'Log In',
                        width: 300,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            authProvider.loginUserwithEmailAndPassword(
                                context,
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                true);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
