import 'package:flutter/material.dart';
import 'package:shopapp/utils/CustomBorder.dart';
import 'package:shopapp/utils/CustomColors.dart';
import 'package:shopapp/utils/CustomTextStyle.dart';
import 'package:shopapp/utils/CustomUtils.dart';

import 'ProductDetailsPage.dart';
import 'SeeAllProductPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listImage = [];
  List<String> listShoesImage = [];
  int selectedSliderPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sliderImage();
    shoesImage();
  }

  void sliderImage() {
    listImage.add("assets/images/slider_img.webp");
    listImage.add("assets/images/slider_img.webp");
    listImage.add("assets/images/slider_img.webp");
  }

  void shoesImage() {
    listShoesImage.add("assets/images/shoes_1.png");
    listShoesImage.add("assets/images/shoes_2.png");
    listShoesImage.add("assets/images/shoes_3.png");
    listShoesImage.add("assets/images/shoes_4.png");
    listShoesImage.add("assets/images/shoes_5.png");
    listShoesImage.add("assets/images/shoes_6.png");
    listShoesImage.add("assets/images/shoes_7.png");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: CustomColors.COLOR_GREEN,
                      height: height / 4,
                    ),
                    /*Search Section*/
                    Container(
                      margin:
                          const EdgeInsets.only(top: 48, right: 24, left: 24),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Search",
                          enabledBorder: CustomBorder.enabledBorder.copyWith(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24))),
                          contentPadding: const EdgeInsets.only(
                              top: 16, left: 12, right: 12, bottom: 8),
                          border: CustomBorder.enabledBorder.copyWith(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24))),
                          enabled: false,
                          filled: true,
                        ),
                      ),
                    ),
                    /*Slider Section*/
                    Container(
                        height: (height / 4) + 75,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: height / 5,
                          child: PageView.builder(
                            itemBuilder: (context, position) {
                              return createSlider(listImage[position]);
                            },
                            controller: PageController(viewportFraction: .8),
                            itemCount: listImage.length,
                            onPageChanged: (position) {
                              /*setState(() {
                              selectedSliderPosition = position;
                            });*/
                            },
                          ),
                        ))
                  ],
                ),
                Utils.getSizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeeAllProductPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Text(
                          "GROUP BY",
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text("SEE ALL",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.grey.shade700)),
                            const Icon(Icons.arrow_forward),
                            Utils.getSizedBox(width: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Utils.getSizedBox(height: 10),
                /*Group By Product Listing*/
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return createGroupBuyListItem(
                          listShoesImage[index], index);
                    },
                    itemCount: listShoesImage.length,
                  ),
                ),

                /*Most Big Product Listing*/
                Utils.getSizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        "MOST BIG",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text("SEE ALL",
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.grey.shade700)),
                          const Icon(Icons.arrow_forward),
                          Utils.getSizedBox(width: 16),
                        ],
                      ),
                    )
                  ],
                ),
                Utils.getSizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return createMostBigListItem(
                          listShoesImage[index], index, context);
                    },
                    itemCount: listShoesImage.length,
                  ),
                ),
                Utils.getSizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  createSlider(String image) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  createGroupBuyListItem(String image, int index) {
    double leftMargin = 0;
    double rightMargin = 0;
    if (index != listShoesImage.length - 1) {
      leftMargin = 10;
    } else {
      leftMargin = 10;
      rightMargin = 10;
    }
    return Container(
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 75,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
            ),
          ),
          Expanded(
            flex: 25,
            child: Container(
              padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
              width: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Utils.getSizedBox(height: 8),
                  Text(
                    "NIKE Kyire II",
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                        color: Colors.black.withOpacity(.7), fontSize: 12),
                  ),
                  Utils.getSizedBox(height: 4),
                  Text(
                    "Exquisite you need him",
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                        color: Colors.black.withOpacity(.7), fontSize: 10),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  createMostBigListItem(String image, int index, BuildContext context) {
    double leftMargin = 0;
    double rightMargin = 0;
    double radius = 16;
    if (index != listShoesImage.length - 1) {
      leftMargin = 10;
    } else {
      leftMargin = 10;
      rightMargin = 10;
    }
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 75,
              child: Hero(
                tag: "$image,$index",
                transitionOnUserGestures: true,
                child: Container(
                  width: 160,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                      ),
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius))),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Utils.getSizedBox(height: 8),
                    Text(
                      "NIKE Kyire II",
                      style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                          color: Colors.black.withOpacity(.7), fontSize: 12),
                    ),
                    Utils.getSizedBox(height: 4),
                    Text(
                      "Exquisite you need him",
                      style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                          color: Colors.black.withOpacity(.7), fontSize: 10),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsPage("$image,$index")));
      },
    );
  }
}
