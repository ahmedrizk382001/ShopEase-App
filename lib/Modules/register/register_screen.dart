import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/login/login_screen.dart';
import 'package:shop_app/Modules/register/cubit/cubit.dart';
import 'package:shop_app/Modules/register/cubit/states.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.model.status) {
              showToast(state.model.message, Colors.black12, Colors.black87);
              noReturningNavigate(context, LoginScreen());
            } else if (!state.model.status) {
              showToast(state.model.message, Colors.black12, Colors.black87);
            }
          }
        },
        builder: (context, state) {
          var registerCubit = ShopRegisterCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        "Please fill the following fields.",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      builtTextFormField(
                        context,
                        validatorFunc: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        labelText: "Enter your Name",
                        prefixIcon: Icon(Icons.person),
                        controller: nameController,
                        keyboardtype: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      builtTextFormField(
                        context,
                        validatorFunc: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Phone";
                          }
                          return null;
                        },
                        labelText: "Enter your Phone",
                        prefixIcon: Icon(Icons.phone_android),
                        controller: phoneController,
                        keyboardtype: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      builtTextFormField(
                        context,
                        validatorFunc: (value) {
                          if (value!.isEmpty) {
                            return "Please enter you email address";
                          }
                          return null;
                        },
                        labelText: "Enter Email Address",
                        prefixIcon: Icon(Icons.email),
                        controller: emailController,
                        keyboardtype: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      builtTextFormField(
                        context,
                        validatorFunc: (value) {
                          if (value!.isEmpty) {
                            return "Please enter you password";
                          }
                          return null;
                        },
                        labelText: "Enter Password",
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            registerCubit.userRegister(
                                nameController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text);
                          }
                        },
                        prefixIcon: Icon(Icons.key_sharp),
                        controller: passwordController,
                        keyboardtype: TextInputType.visiblePassword,
                        isPassword: registerCubit.isPassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              registerCubit.changeShowPassowrd();
                            },
                            icon: registerCubit.passwordIcon),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is! ShopRegisterLoadingState)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  registerCubit.userRegister(
                                      nameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(defaultColor),
                              ),
                              child: Text(
                                "Register",
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                        ),
                      if (state is ShopRegisterLoadingState)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      Text(
                        "When registeration is doen, You will be forwarding to the login page automatically.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
