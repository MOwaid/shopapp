import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../../../Models/DBHelper.dart';
import '../../../Models/Settings.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../../Models/Cart.dart';
import '../../order_success/order_success_screen.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({super.key});

  @override
  // ignore: no_logic_in_create_state
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  _CheckoutCardState();

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
  }

  double total = 0.00;
  @override
  Widget build(BuildContext context) {
    total = 0;
    Provider.of<CartOne>(context, listen: true).items.forEach(
        (element) => total = total + (element.productPrice * element.quantity));

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(30),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Add Message:"),
                const SizedBox(width: 5),
                InkWell(
                  borderRadius: BorderRadius.circular(2.0),
                  onTap: () {
                    _showModal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: getProportionateScreenWidth(40),
                      width: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/receipt.svg"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Payument type: Cash On Delivery ( COD )"),
                const SizedBox(width: 5),
                InkWell(
                  borderRadius: BorderRadius.circular(2.0),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: getProportionateScreenWidth(40),
                      width: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/Cash.svg"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "Rs: $total/-",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      _ordersubmitted();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _ordersubmitted() async {
    CartOne cartCheckout = Provider.of<CartOne>(context, listen: false);
    cartCheckout.id = M.ObjectId();
    cartCheckout.totalPrice = total;
    cartCheckout.itemcount = cartCheckout.items.length;
    cartCheckout.totalQuantity = cartCheckout.itemcount;
    cartCheckout.orderStatus = 1;
    cartCheckout.orderdate = DateTime.now();
    cartCheckout.vat = (total * 20) / 100;
    cartCheckout.posCharges = 1.00;

    bool result = await DBHelper.insertCart(cartCheckout);

    if (result == true) {
      // ignore: use_build_context_synchronously
      Provider.of<CartOne>(context, listen: false).items.clear();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, OrderSuccessScreen.routeName,
          arguments: PageArguments(
              message: "Order Placed",
              buttonlabel: "Close",
              perviousPagename: "OrderComplete"));
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, "Error",
          "Unable to place the order at this moment. Please try again later!");
    }
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
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 5,
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

        filled: true,
        fillColor: Colors.green[20],
        labelStyle: const TextStyle(color: Colors.green),
        hintText: "Please enter a message with your order.",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
      ),
    );
  }

  final List<String?> errors = [];
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

  void _showModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // height: 174,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          margin: const EdgeInsets.only(left: 10, right: 10),
          // You can wrap this Column with Padding of 8.0 for better design
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(height: 15.0),
            const Text(
              'Add Massage',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15.0),
            buildTitleFormField(),
            SizedBox(height: 15.0),
            TextButton(
                onPressed: () {
                  Provider.of<CartOne>(context, listen: false).note =
                      titleController.text;
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        );
      },
    );
  }
}
