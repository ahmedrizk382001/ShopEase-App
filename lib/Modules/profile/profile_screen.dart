import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/profile/profileCubit/cubit.dart';
import 'package:shop_app/Modules/profile/profileCubit/states.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var formmKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopProfileCubit()..getUserData(),
      child: BlocConsumer<ShopProfileCubit, ShopProfileState>(
        listener: (context, state) {
          if (state is ShopUpdateSuccessState) {
            showToast(ShopProfileCubit.get(context).loginModel.message,
                Colors.black12, Theme.of(context).textTheme.bodyLarge!.color);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    )),
                title: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                )),
            body: ConditionalBuilder(
              condition: state is! ShopGetUserDataLoadingState &&
                  state is! ShopUpdateLoadingState,
              builder: (context) {
                var profileCubit = ShopProfileCubit.get(context);
                emailController.text =
                    profileCubit.getUserDataModel.data!.email;
                phoneController.text =
                    profileCubit.getUserDataModel.data!.phone;
                nameController.text = profileCubit.getUserDataModel.data!.name;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formmKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            suffixIcon: IconButton(
                                onPressed: () {
                                  profileCubit.changeShowPassowrd();
                                },
                                icon: profileCubit.passwordIcon),
                            isPassword: profileCubit.isPassword,
                            context,
                            validatorFunc: (value) {
                              if (value!.isEmpty) {
                                return "Please enter you pasword to confirm";
                              }
                              return null;
                            },
                            labelText: "Enter you Pasword to Confirm",
                            prefixIcon: Icon(Icons.key),
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopUpdateLoadingState,
                            builder: (context) => Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (formmKey.currentState!.validate()) {
                                          profileCubit.userUpdate(
                                              email: emailController.text,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                defaultColor),
                                      ),
                                      child: Text(
                                        "Update",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        signOut('token', context);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.grey),
                                      ),
                                      child: Text(
                                        "Sign Out",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )),
                                ),
                              ],
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
