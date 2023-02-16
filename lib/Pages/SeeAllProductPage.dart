import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopapp/utils/CustomTextStyle.dart';
import 'package:shopapp/utils/CustomUtils.dart';

class SeeAllProductPage extends StatefulWidget {
  const SeeAllProductPage({super.key});

  @override
  _SeeAllProductPageState createState() => _SeeAllProductPageState();
}

class _SeeAllProductPageState extends State<SeeAllProductPage> {
  List<String> listImage = [];
  List<Color> listItemColor = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addImage();
    addItemColor();
  }

  void addItemColor() {
    listItemColor.add(Colors.white);
    listItemColor.add(Colors.black);
    listItemColor.add(Colors.indigo);
    listItemColor.add(Colors.teal);
    listItemColor.add(Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(child: filterSortListOption(), preferredSize: const Size(double.infinity, 44)),
        title: Text(
          "GROUP BY",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 16),
        ),
        elevation: 1,
        centerTitle: true,
        actions: const <Widget>[
          Image(
            image: AssetImage("assets/images/ic_search.png"),
            width: 48,
            height: 16,
          ),
          Image(
            image: AssetImage("assets/images/ic_shopping_cart.png"),
            width: 48,
            height: 16,
          )
        ],
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.grey.shade100,
            margin: const EdgeInsets.only(bottom: 8, left: 4, right: 4, top: 8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.68),
              itemBuilder: (context, position) {
                return gridItem(context, position);
              },
              itemCount: listImage.length,
            ),
          );
        },
      ),
    );
  }

  filterSortListOption() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: filterRow(Icons.filter_list, "Filter"),
            flex: 30,
          ),
          divider(),
          Expanded(
            child: filterRow(Icons.sort, "Sort"),
            flex: 30,
          ),
          divider(),
          Expanded(
            child: filterRow(Icons.list, "List"),
            flex: 30,
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: 2,
      color: Colors.grey.shade400,
      height: 20,
    );
  }

  filterRow(IconData icon, String title) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey,
          ),
          Utils.getSizedBox(width: 4),
          Text(
            title,
            style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.black.withOpacity(0.8), fontSize: 12),
          )
        ],
      ),
    );
  }

  gridItem(BuildContext context, int position) {
    return GestureDetector(
      onTap: () {
        filterBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: Colors.grey.shade200)),
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 12),
              alignment: Alignment.topRight,
              child: Container(
                alignment: Alignment.center,
                width: 24,
                height: 24,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.indigo),
                child: Text(
                  "30%",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
            Image(
              image: AssetImage(listImage[position]),
              height: 170,
              fit: BoxFit.none,
            ),
            gridBottomView()
          ],
        ),
      ),
    );
  }

  gridBottomView() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            "Chair Dacey li - Black",
            style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 12),
            textAlign: TextAlign.start,
          ),
        ),
        Utils.getSizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "\$50.00",
              style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.indigo.shade700, fontSize: 14),
            ),
            Utils.getSizedBox(width: 8),
            Text(
              "\$80.00",
              style: CustomTextStyle.textFormFieldBold
                  .copyWith(color: Colors.grey, fontSize: 14, decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
        Utils.getSizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          /*  FlutterRatingBar(
              initialRating: 4,
              itemSize: 14,
              itemCount: 5,
              fillColor: Colors.amber,
              borderColor: Colors.amber.withAlpha(50),
              allowHalfRating: true,
              onRatingUpdate: (rating) {},
            ),*/
            Utils.getSizedBox(width: 4),
            Text(
              "4.5",
              style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.black, fontSize: 14),
            ),
          ],
        )
      ],
    );
  }

  void addImage() {
    listImage.add("assets/images/ic_chair.png");
    listImage.add("assets/images/ic_chair1.png");
    listImage.add("assets/images/ic_chair2.png");
    listImage.add("assets/images/ic_chair4.png");
    listImage.add("assets/images/ic_table.png");
    listImage.add("assets/images/ic_table1.png");
  }

  filterBottomSheet(BuildContext context) {
    _scaffoldKey.currentState?.showBottomSheet(
          (context) {
        return filterBottomSheetContent();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
    );
  }

  filterBottomSheetContent() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Utils.getSizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(
                Icons.close,
              ),
              Text(
                "Filter",
                style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.black.withOpacity(0.8), fontSize: 16),
              ),
              Text(
                "Reset",
                style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.indigo, fontSize: 16),
              ),
            ],
          ),
          Utils.getSizedBox(height: 28),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text("Price Range", style: CustomTextStyle.textFormFieldMedium),
          ),
          Utils.getSizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 47,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Minimum",
                    hintStyle: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.grey.shade800),
                    focusedBorder: border,
                    contentPadding: const EdgeInsets.only(right: 8, left: 8, top: 12, bottom: 12),
                    border: border,
                    enabledBorder: border,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 47,
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Maximum",
                      hintStyle: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.grey.shade800),
                      focusedBorder: border,
                      contentPadding: const EdgeInsets.only(right: 8, left: 8, top: 12, bottom: 12),
                      border: border,
                      enabledBorder: border,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text("Item Filter", style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 16)),
          ),
          Utils.getSizedBox(height: 8),
          ListView.builder(
            primary: false,
            itemBuilder: (context, position) {
              return Container(
                margin: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Discount",
                          style: CustomTextStyle.textFormFieldRegular.copyWith(fontSize: 14, color: Colors.grey),
                        ),
                        const Icon(
                          Icons.check,
                          color: Colors.indigo,
                        )
                      ],
                    ),
                    Utils.getSizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
            itemCount: 3,
            shrinkWrap: true,
          ),
          Utils.getSizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text("Item Color", style: CustomTextStyle.textFormFieldMedium),
          ),
          Utils.getSizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 30),
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: listItemColor[position]),
                );
              },
              itemCount: listItemColor.length,
              shrinkWrap: true,
            ),
          ),
          Utils.getSizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(

                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                  backgroundColor: Colors.indigo),



              child: Text(
                "Apply Filter",
                style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1));
}
