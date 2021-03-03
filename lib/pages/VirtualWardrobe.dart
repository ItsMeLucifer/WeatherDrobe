import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/cloth_creator_page_view.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/clothes_list.dart';

class VirtualWardrobe extends StatefulWidget {
  @override
  _VirtualWardrobe createState() => _VirtualWardrobe();
}

class _VirtualWardrobe extends State<VirtualWardrobe> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  void _navigateToClothCreator(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClothCreatorPV()));
  }

  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(220, 220, 220, 1);
    const Color textColor = Colors.black;
    const String fontFamily = "Nexa";
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(waterDropColor: primaryColor),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _navigateToClothCreator(context),
                child: Card(
                    child: Container(
                        width: 400,
                        height: 100,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(children: [
                                Center(
                                  child: Text("+ ",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: textColor,
                                          fontFamily: fontFamily),
                                      textAlign: TextAlign.center),
                                ),
                                Center(
                                  child: Text(
                                    "New Clothing",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: textColor,
                                        fontFamily: fontFamily),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ])
                            ]),
                        color: primaryColor)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    child: Text(
                  'Your Virtual Wardrobe:',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w500),
                )),
              ),
              ClothesList()
            ],
          ),
        ));
  }
}
