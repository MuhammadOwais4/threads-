import 'package:demo/controllers/auth_controller.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/widgets/auth/auth_button.dart';
import 'package:demo/widgets/auth/auth_header.dart';
import 'package:demo/widgets/auth/auth_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  void submit() {
    if (_key.currentState!.validate()) {
      controller.login(
        emailTextEditingController.text,
        passwordTextEditingController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthHeader(
                title: "Login",
                description: "Welcome Back",
              ),
              AuthTextField(
                labelText: "Email",
                validator: ValidationBuilder()
                    .required("please enter the email")
                    .email("Please enter a valid email")
                    .build(),
                obscureText: false,
                controller: emailTextEditingController,
              ),
              AuthTextField(
                labelText: "Password",
                validator: ValidationBuilder()
                    .required("please enter the password")
                    .build(),
                obscureText: true,
                controller: passwordTextEditingController,
              ),
              Obx(
                () {
                  return AuthButton(
                    label: controller.loginLoading.value ? "Processing" : "Login",
                    onPressed:submit ,
                    
                  );
                },
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: " Sign up",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(
                            RoutesNames.register,
                          );
                        },
                    ),
                  ],
                  text: "Don't have an account ?",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
