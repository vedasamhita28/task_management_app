import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/auth/providers/auth_provider.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/constants/style.dart';
import 'package:task_management_app/constants/utils.dart';
import 'package:task_management_app/widgets/appbar_widget.dart';
import 'package:task_management_app/widgets/primary_button.dart';
import 'package:task_management_app/widgets/snack_bar.dart';
import 'package:task_management_app/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinNumController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isTLUser = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppbarWidget(
        title: "Sign Up",
        backArraw: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/signup_img.png'),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryBgColor,
                boxShadow: AppColors.cardBoxShadow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              width: double.infinity,
              child: Form(
                key: formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: Style.subHeadingStyle,
                      ),
                      gapH20,
                      PrimaryTextField(
                        hintText: "Enter your Email",
                        controller: emailController,
                        isRequried: true,
                      ),
                      gapH20,
                      PrimaryTextField(
                        hintText: "Enter your Name",
                        controller: nameController,
                        isRequried: true,
                      ),
                      gapH20,
                      PrimaryTextField(
                        hintText: "Enter Your Password",
                        controller: passwordController,
                        isRequried: true,
                        obscureText: true,
                      ),
                      gapH20,
                      CheckboxListTile(
                        title: Text("Are you Team Leader ?"),
                        value: isTLUser,
                        onChanged: (bool? newVal) {
                          setState(() {
                            isTLUser = newVal ?? false;
                          });
                        },
                      ),
                      gapH20,
                      Visibility(
                        visible: isTLUser,
                        child: PrimaryTextField(
                          hintText: "Enter TL Pin",
                          controller: pinNumController,
                          isRequried: true,
                        ),
                      ),
                      gapH20,
                      PrimaryButton(
                        text: 'Sign Up',
                        width: 300,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            (isTLUser)
                                ? (pinNumController.text ==
                                        '123456') // can be future enhanced by getting the Code from DB
                                    ? authProvider
                                        .createUserwithEmailAndPassword(
                                            context,
                                            nameController.text,
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                            isTLUser)
                                    : CustomSnackbar.show(
                                        context: context,
                                        message:
                                            "The PIn Number You have entered is not Correct, If Your an en Employee Uncheck the TL Check box",
                                        type: SnackbarType.error)
                                : authProvider.createUserwithEmailAndPassword(
                                    context,
                                    nameController.text,
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    isTLUser);
                            CustomSnackbar.show(
                                context: context,
                                message:
                                    "Registration Success Can you Please Login Once",
                                type: SnackbarType.success);
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
