import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:shopapp/components/default_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/components/form_error.dart';

import '../../../Models/DBHelper.dart';
import '../../../Models/Product.dart';
import '../../../Models/ProductVariation.dart';
import '../../../Models/User.dart';

import '../../../utils/Constants.dart';
import '../../../utils/size_config.dart';

import '../../../Models/firebase.dart';
import '../../prod_success/prod_success_screen.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  // ignore: no_logic_in_create_state
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  _AddProductFormState();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? dob;
  String? phoneNumber;
  String? address;
  String _selectedValue = "Pizza's";
  String _selectedrate = "5";
  bool _termsChecked = false;
  bool isOffer = false;
  bool isDeal = false;
  bool isAvailable = false;

  var _limitvariation = 5;

  TextEditingController pathController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController QtyController = TextEditingController();
  TextEditingController ExtraController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  TextEditingController varnameController = TextEditingController();
  TextEditingController varpriceController = TextEditingController();

  late FocusNode vFocusNode;
  late FocusNode pFocusNode;

  final List<ProductVariation> pVar = [];

  var listindex = 0;
  TextEditingController nameController = TextEditingController();
  String imageUrl = "";
  XFile? pickedImage;

  void addItemToList() {
    if (varnameController.text.isEmpty || varpriceController.text.isEmpty) {
      if (varnameController.text.isEmpty) {
        vFocusNode.requestFocus();
        return;
      } else {
        pFocusNode.requestFocus();
        return;
      }
    } else {
      if (pVar.length < _limitvariation) {
        ProductVariation newvar = ProductVariation(
            id: M.ObjectId(),
            type: varnameController.text,
            color: ExtraController.text,
            price: double.parse(varpriceController.text),
            qty: double.parse(QtyController.text));
        pVar.add(newvar);
        // Varnames.insert(0, varnameController.text);
        // vrPrice.insert(0, varpriceController.text);
      }
    }
    setState(() {});
  }

  void removeItemToList(var lindex) {
    if (pVar.isNotEmpty && pVar.length - 1 >= lindex) {
      pVar.removeAt(lindex);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //pVar.add(vp);
    ExtraController.text = "-";
    QtyController.text = "-1";
    ratingController.text = "5.0";
    vFocusNode = FocusNode();
    pFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pathController.dispose();
    titleController.dispose();
    discController.dispose();
    priceController.dispose();
    ratingController.dispose();

    vFocusNode.dispose();
    pFocusNode.dispose();

    catagoryController.dispose();
    sizeController.dispose();
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

  Widget _listItem(index) {
    if (pVar.isEmpty) {
      return const SizedBox(
        height: 35,
        child: Text("variation / size / color/ etc",
            style: TextStyle(fontSize: 14)),
      );
    } else {
      return SizedBox(
          height: 35,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0, color: Colors.black26))),
            child: ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: Text(index.toString(),
                      style: const TextStyle(fontSize: 14)),
                ),
                title: SizedBox(
                    height: double.infinity,
                    child: Text(
                      "${pVar[index].type} - ${pVar[index].color}            ${pVar[index].qty}",
                      style: const TextStyle(fontSize: 14),
                    )),
                trailing: SizedBox(
                    height: double.infinity,
                    child: Text("Rs: ${pVar[index].price}/-",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.purple))),
                onTap: () {
                  //                                  <-- onTap
                  setState(() {
                    listindex = index;
                  });
                }),
          ));
    }
  }

  // ignore: non_constant_identifier_names
  Widget _ErrorImage() {
    return Container(
      height: 120.0,
      width: 120.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/glap.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Future<void> chooseImage(inputSource) async {
    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      setState(() {
        imageUrl = pickedImage!.path;
      });
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

// ignore: non_constant_identifier_names
  ImageProvider<Object> Makeimage() {
    if (imageUrl == "") {
      return const AssetImage('assets/images/uploadplaceholder.png');
    } else {
      return FileImage(File(imageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      elevation: 3,
                      margin: const EdgeInsets.only(left: 70, right: 70),
                      child: SizedBox(
                        height: 180.0,
                        child: Image(
                          image: Makeimage(),
                        ),
                      ))),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(left: 70, right: 70),
              child: IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  chooseImage('gallery');
                },
              ),
            ))
          ]),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildTitleFormField(),
          SizedBox(height: getProportionateScreenHeight(5)),
          builddiscFormField(),
          SizedBox(height: getProportionateScreenHeight(5)),
          SizedBox(
              height: 37,
              width: SizeConfig.screenWidth * 0.88,
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 32),
                color: Colors.amber,
                child: const ListTile(
                  leading: SizedBox(
                      height: double.infinity,
                      child: Text('ID',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                  title: SizedBox(
                      height: double.infinity,
                      child: Text('Name/Extra               Qty',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                  trailing: SizedBox(
                      height: double.infinity,
                      child: Text('Price',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                elevation: 3,
                child: SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: pVar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: _listItem(index),
                      );
                    },
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: SizedBox(
                    child: TextField(
              focusNode: vFocusNode,
              controller: varnameController,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.type_specimen,
                  color: Colors.green,
                ),
                filled: true,
                fillColor: Colors.green[50],
                labelStyle: const TextStyle(color: Colors.green),
                hintText: "Size.",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
              ),
            ))),
            const SizedBox(width: 5),
            Expanded(
                child: SizedBox(
                    width: 10,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      focusNode: pFocusNode,
                      controller: varpriceController,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.money,
                          color: Colors.green,
                        ),
                        filled: true,
                        fillColor: Colors.green[50],
                        labelStyle: const TextStyle(color: Colors.green),
                        hintText: "Price.",
                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                      ),
                    ))),
            const SizedBox(width: 5),
            Expanded(
              child: SizedBox(width: 115, child: buildQtyFormField()),
            ),
          ]),
          SizedBox(height: getProportionateScreenHeight(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 205, child: buildExtrFormField()),
              const SizedBox(width: 10),
              const Text("Rate:",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(width: 5),
              Expanded(child: buildrateDropdownFormField())
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Cat:",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              SizedBox(width: 190, child: buildSizeDropdownFormField()),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  addItemToList();
                },
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  removeItemToList(listindex);
                },
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(5)),
          SizedBox(
              child: DefaultButton(
            text: "Add",
            press: () {
              if (_formKey.currentState!.validate()) {
                insertProduct();
                // Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          )),
        ],
      ),
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      controller: titleController,
      onSaved: (newValue) => titleController.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: ktitleNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: ktitleNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixIcon: const Icon(
          Icons.ad_units,
          color: Colors.green,
        ),
        filled: true,
        fillColor: Colors.green[50],
        labelStyle: const TextStyle(color: Colors.green),
        hintText: "Enter product name.",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
      ),
    );
  }

  TextFormField builddiscFormField() {
    return TextFormField(
      controller: discController,
      onSaved: (newValue) => discController.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kdiscNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kdiscNullError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      minLines: 1, // <-- SEE HERE
      maxLines: 5, // <-- SEE HERE
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixIcon: const Icon(
          Icons.description,
          color: Colors.green,
        ),
        filled: true,
        fillColor: Colors.green[50],
        labelStyle: const TextStyle(color: Colors.green),
        hintText:
            "Enter product Description \nWrite product details \nSize - Color - Topping etc \nMax 100 words.",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
      ),
    );
  }

  TextFormField buildQtyFormField() {
    return TextFormField(
      controller: QtyController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => QtyController.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kqtyNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kqtyNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixIcon: const Icon(
          Icons.production_quantity_limits_sharp,
          color: Colors.green,
        ),
        filled: true,
        fillColor: Colors.green[50],
        labelStyle: const TextStyle(color: Colors.green),
        hintText: "-1 ",
      ),
    );
  }

  TextFormField buildExtrFormField() {
    return TextFormField(
      controller: ExtraController,
      onSaved: (newValue) => QtyController.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kqtyNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kqtyNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixIcon: const Icon(
          Icons.collections,
          color: Colors.green,
        ),
        filled: true,
        fillColor: Colors.green[50],
        labelStyle: const TextStyle(color: Colors.green),
        hintText: "Extra",
      ),
    );
  }

  TextFormField buildpathFormField() {
    return TextFormField(
      controller: pathController,
      onSaved: (newValue) => pathController.text = newValue!,
      decoration: const InputDecoration(
        labelText: "Product Image",
        hintText: "Enter your product image.",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.image),
      ),
      style: const TextStyle(fontSize: 14),
      readOnly: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          pathController.text = value;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kimgpathNullError);
          return "";
        }
        return null;
      },
      onTap: () async {
        FirebaseHelper.upload('gallery');
        setState(() {});
      },
    );
  }

  DropdownButtonFormField buildSizeDropdownFormField() {
    return DropdownButtonFormField(
        validator: (value) => value == null ? "Select Catagory" : null,
        dropdownColor: Colors.white,
        value: _selectedValue,
        hint: const Text(
          'Choose Catagory',
        ),
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          prefixIcon: const Icon(
            Icons.category_rounded,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green[50],
          labelStyle: const TextStyle(color: Colors.green),
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        onSaved: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        items: dropdownItems);
  }

  DropdownButtonFormField buildrateDropdownFormField() {
    return DropdownButtonFormField(
        validator: (value) => value == null ? "Rate" : null,
        dropdownColor: Colors.white,
        value: _selectedrate,
        hint: const Text(
          'Choose Ratting',
        ),
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          prefixIcon: const Icon(
            Icons.rate_review,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green[50],
          labelStyle: const TextStyle(color: Colors.green),
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            ratingController.text = value;
          });
        },
        onSaved: (value) {
          setState(() {
            ratingController.text = value;
          });
        },
        items: dropdownRate);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Burger's", child: Text("Burger's")),
      const DropdownMenuItem(value: "Pizza's", child: Text("Pizza's")),
      const DropdownMenuItem(value: "Wings", child: Text("Wings")),
      const DropdownMenuItem(value: "HotShots", child: Text("HotShots")),
      const DropdownMenuItem(value: "Platter", child: Text("Fried Platter")),
      const DropdownMenuItem(value: "Fries", child: Text("Loaded Fries")),
      const DropdownMenuItem(value: "Drinks", child: Text("Beverages")),
      const DropdownMenuItem(value: "Deals", child: Text("Deals")),
      const DropdownMenuItem(value: "Paratha's", child: Text("Paratha's")),
      const DropdownMenuItem(value: "Offers", child: Text("Offers")),
      const DropdownMenuItem(value: "Papolar", child: Text("Papolar")),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownRate {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "5", child: Text("5")),
      const DropdownMenuItem(value: "4", child: Text("4")),
      const DropdownMenuItem(value: "3", child: Text("3")),
      const DropdownMenuItem(value: "2", child: Text("2")),
      const DropdownMenuItem(value: "1", child: Text("1")),
    ];
    return menuItems;
  }

  Widget buildTextField1() => TextFormField(
      decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.person,
            color: Colors.teal,
          ),
          hintText: 'Enter your Name',
          hintStyle: TextStyle(color: Colors.teal)));

  Widget buildTextField2() => TextFormField(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.orange,
          ),
          hintText: "Enter your Name",
          hintStyle: TextStyle(color: Colors.orange),
        ),
      );

  Widget buildTextField3() => TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          prefixIcon: const Icon(Icons.person, color: Colors.blue),
          hintText: "Enter your Name",
          hintStyle: const TextStyle(color: Colors.blue),
          filled: true,
          fillColor: Colors.blue[50],
        ),
      );

  Widget buildTextField4() => TextFormField(
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green[50],
          labelText: "Enter your Name",
          labelStyle: const TextStyle(color: Colors.green),
        ),
      );

  Widget buildTextField5() => TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.red,
          ),
          filled: true,
          fillColor: Colors.red[50],
          labelText: "Enter your Name",
          labelStyle: const TextStyle(color: Colors.red),
        ),
      );

  Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
  bool validateAll() {
    if (imageUrl.isEmpty) {
      showAlertDialog(
          context, "Add Image", "Please add product Image to continue!");
      return false;
    }
    if (pVar.isEmpty) {
      showAlertDialog(context, "Add Variations",
          "Please add product variations to continue!");
      return false;
    }
    if (titleController.text.isEmpty ||
        discController.text.isEmpty ||
        _selectedValue.isEmpty ||
        ratingController.text.isEmpty) {
      showAlertDialog(context, "Add title",
          "Please add product title and descriptionto continue!");

      return false;
    } else {
      if (_selectedValue == "Offers") {
        isOffer = true;
      }
      if (_selectedValue == "Deals") {
        isDeal = true;
      }
    }

    return true;
  }

  insertProduct() async {
    if (validateAll() == false) {
      return;
    }

    final List<String> imglist = [];

    String filename = "";
    await FirebaseHelper.uploadfile(imageUrl).then((String result) {
      setState(() {
        filename = result;
      });
    });
    if (filename == "") {
      return;
    } else {
      imglist.add(filename);
    }

    final Product newProduct = Product(
        id: M.ObjectId(),
        images: imglist,
        variation: pVar,
        rating: double.parse(ratingController.text),
        isFavourite: true,
        isPopular: true,
        isOffer: isOffer,
        isDeal: isDeal,
        isAvailable: isAvailable,
        title: titleController.text,
        description: discController.text,
        cat: _selectedValue);

    final bool result = await DBHelper.insertProduct(newProduct);
    if (result == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ProdSuccessScreen.routeName);
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(
          context, "Error", "Unable to add new product to database!");
    }
  }
}
