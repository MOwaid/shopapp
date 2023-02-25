import 'package:flutter/material.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:intl/intl.dart';
import '../../../Models/Address.dart';
import '../../../Models/DBHelper.dart';
import '../../../Models/Settings.dart';
import '../../../Models/User.dart';

import '../../../utils/Constants.dart';
import '../../../utils/size_config.dart';
import '../../login_success/login_success_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  // ignore: no_logic_in_create_state
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  _CompleteProfileFormState();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? dob;
  String? phoneNumber;
  String? address;

  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    dobController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          builddobFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                insertUser(user!);
                // Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your full address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField builddobFormField() {
    return TextFormField(
      controller: dobController,
      onSaved: (newValue) => dob = newValue,
      decoration: const InputDecoration(
        labelText: "Date of Birth",
        hintText: "Enter your date of birth",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          dob = value;
        }
        return;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

          dob = formattedDate; //set output date to TextField value.
          dobController.text = formattedDate;

          setState(() {});
        } else {}
      },
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: nameController,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your full name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  insertUser(User userDB) async {
    final Address adr = Address(
        id: M.ObjectId(),
        houseNo: '00',
        streetline1: addressController.text,
        city: 'Karachi',
        state: 'Sindh',
        country: 'Pakistan');

    final User u = User(
        id: M.ObjectId(),
        userID: userDB.userID,
        name: nameController.text,
        password: userDB.password,
        passhint: userDB.passhint,
        address: adr,
        email: userDB.email,
        dob: dob!,
        mobileno1: userDB.mobileno1,
        mobileno2: '00923343441685');

    final bool result = await DBHelper.insert(u);
    if (result == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginSuccessScreen.routeName,
          arguments: PageArguments(
              message: "Successfully Added",
              buttonlabel: "Back to Login",
              perviousPagename: "Added"));

//      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    } else {
      showAlertDialog(
          context, "User Exist", "User already exist with this number!");
    }
    // ignore: use_build_context_synchronously
  }
}
