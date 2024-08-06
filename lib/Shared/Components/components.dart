import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_app/Modules/login/login_screen.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

Widget builtTextFormField(
  BuildContext context, {
  TextInputType keyboardtype = TextInputType.text,
  required String? Function(String?) validatorFunc,
  required String labelText,
  required Widget prefixIcon,
  Widget? suffixIcon,
  bool isPassword = false,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  required TextEditingController? controller,
}) =>
    TextFormField(
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isPassword,
      controller: controller,
      cursorColor: defaultColor,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardtype,
      validator: validatorFunc,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultColor,
            ),
            borderRadius: BorderRadius.circular(15)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        hintMaxLines: 1,
        prefixIcon: prefixIcon,
      ),
    );

Future<bool?> showToast(
  String message,
  Color backgroundColor,
  Color? textColor,
) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);

Future<dynamic> noReturningNavigate(BuildContext context, Widget page) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => page,
        ),
        (route) => false);

Widget getDivider(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 15,
      bottom: 15,
    ),
    child: Container(
      height: 1,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}

void signOut(String key, BuildContext context) {
  CacheHelper.removeData(key).then((value) {
    if (value) {
      noReturningNavigate(context, LoginScreen()).catchError((error) {
        print("Error While signout");
      });
    }
  });
}

Widget centerIndicator() =>
    Center(child: CircularProgressIndicator(color: defaultColor));
