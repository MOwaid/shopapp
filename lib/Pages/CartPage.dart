import 'package:flutter/material.dart';
import 'package:shopapp/utils/CustomTextStyle.dart';
import 'package:shopapp/utils/CustomUtils.dart';

import 'CheckOutPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[createHeader(), createSubTitle(), createCartList(), footer(context)],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  "\$299.00",
                  style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.greenAccent.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutPage()));
            },

            style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 5, color: Colors.red),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                backgroundColor: Colors.black,
                padding:
                const EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12)),

            child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
            ),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 12, top: 12),
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 16, color: Colors.black),
      ),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 12, top: 4),
      child: Text(
        "Total(3) Items",
        style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem();
      },
      itemCount: 5,
    );
  }

  createCartListItem() {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: const DecorationImage(image: AssetImage("assets/images/shoes_1.png"))),
              ),
              Expanded(
                flex: 100,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          "NIKE XTM Basketball Shoeas",
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      Text(
                        "Green M",
                        style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "\$299.00",
                            style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.remove,
                                  size: 24,
                                  color: Colors.grey.shade700,
                                ),
                                Container(
                                  color: Colors.grey.shade200,
                                  padding: const EdgeInsets.only(bottom: 2, right: 12, left: 12),
                                  child: Text(
                                    "2",
                                    style: CustomTextStyle.textFormFieldSemiBold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: (){
                                    //action coe when button is pressed

                                    print("The icon is clicked");
                                  },

                                  icon:  Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  ),
                                ),



                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10, top: 8),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.green),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
