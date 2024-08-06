import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_layout.dart';
import 'package:shop_app/Modules/login/login_cubit/cubit.dart';
import 'package:shop_app/Modules/login/login_cubit/states.dart';
import 'package:shop_app/Modules/register/register_screen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.model.status) {
              CacheHelper.setString("token", state.model.data!.token);
              token = state.model.data!.token;
              print(token);
              //ShopRegisterCubit.get(context).getUserData();
              noReturningNavigate(context, ShopAppLayout());
            } else if (!state.model.status) {
              showToast(state.model.message, Colors.black12,
                  Theme.of(context).textTheme.bodyLarge!.color);
            }
          }
        },
        builder: (context, state) {
          var loginCubit = ShopLoginCubit.get(context);
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            "Welcome back! Please log in to continue.",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                return "Please Enter you email address";
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
                                return "Please Enter you password";
                              }
                              return null;
                            },
                            labelText: "Enter Password",
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(emailController.text,
                                    passwordController.text);
                              }
                            },
                            prefixIcon: Icon(Icons.key_sharp),
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                            isPassword: loginCubit.isPassword,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginCubit.changeShowPassowrd();
                                },
                                icon: loginCubit.passwordIcon),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          if (state is! ShopLoginLoadingState)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.userLogin(emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(defaultColor),
                                  ),
                                  child: Text(
                                    "Login",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )),
                            ),
                          if (state is ShopLoginLoadingState)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          if (state is! ShopLoginLoadingState)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                    onPressed: () {
                                      noReturningNavigate(
                                          context, RegisterScreen());
                                    },
                                    child: Text(
                                      "REGISTER.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: defaultColor,
                                              fontWeight: FontWeight.w600),
                                    ))
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
