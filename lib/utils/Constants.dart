import 'package:flutter/material.dart';
import 'package:shopapp/utils/size_config.dart';

// ignore: constant_identifier_names
const MONGO_CONN_URL =
    "mongodb+srv://dbUser:Rida11611@ebaydata.mig4x.mongodb.net/PizzaADDA";
// ignore: constant_identifier_names
const USER_COLLECTION = "users";
const PRODUCT_COLLECTION = "products";
const ORDER_COLLECTION = "Orders";
// ignore: constant_identifier_names
const USER_CART = "Cart";

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final headingStyle1 = TextStyle(
  fontSize: getProportionateScreenWidth(22),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.4,
);
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatorRegExp = RegExp(r"^[0-9]");
const String kEmailNullError = "Please Enter your email";
const String kuserIdNullError = "Please Enter your mobile no";
const String kNameNullError = "Please Enter your fuill name";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kPhoneNumberOnly = "Please Enter your valid phone number";
const String kPhoneNumberlong = "Phone no should be 11 digits long eg:03XX";

const String kAddressNullError = "Please Enter your address";

const String ktitleNullError = "Please Enter product title";
const String kdiscNullError = "Please Enter product discription";
const String kqtyNullError = "Add at least one value";
const String kfavNullError = "Please select product category";
const String kratNullError = "Please select product rating";
const String kimgpathNullError = "Please Enter product image";
const String kpricehNullError = "Please Enter product price";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

showAlertDialog(BuildContext context, String title, String message) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("Close"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
