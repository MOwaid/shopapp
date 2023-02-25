import 'package:flutter/material.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/components/form_error.dart';

import 'package:intl/intl.dart';
import '../../../Models/Address.dart';
import '../../../Models/DBHelper.dart';
import '../../../Models/Settings.dart';
import '../../../Models/User.dart';

import '../../../utils/Constants.dart';
import '../../../utils/size_config.dart';
import '../../login_success/login_success_screen.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  // ignore: no_logic_in_create_state
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  _UpdateProfileFormState();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? dob;
  String? phoneNumber;
  String? address;
  bool change = false;

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

  @override
  void initState() {
    super.initState();
    //pVar.add(vp);

    nameController.text = DBHelper.currentUser.name;
    phoneController.text = DBHelper.currentUser.mobileno1;
    addressController.text = DBHelper.currentUser.address.streetline1;
    dobController.text = DBHelper.currentUser.dob;
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
    final User user = DBHelper.currentUser;
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
                if (change == true) {
                  updatetUser(user);
                } else {
                  Navigator.pop(context);
                }
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
        change = true;

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
        change = true;

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
          dobController.text = value;
        }
        change = true;
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

          setState(() {
            change = true;
          });
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
        change = true;

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

  updatetUser(User userDB) async {
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
        dob: dobController.text,
        mobileno1: userDB.mobileno1,
        mobileno2: '00923343441685');

    final bool result = await DBHelper.update(u);
    if (result == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginSuccessScreen.routeName,
          arguments: PageArguments(
              message: "Profile updated!",
              buttonlabel: "Close",
              perviousPagename: "update"));

      //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, "Update Error",
          "Unable to update user data please try again later!");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    // ignore: use_build_context_synchronously
  }
}
