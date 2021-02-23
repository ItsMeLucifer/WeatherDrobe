import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/cloth_creator.dart';
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
    return GestureDetector(
        onTap: () {
          //wyswietl material page route
        },
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(waterDropColor: Colors.teal),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    Icon(Icons.add, color: Colors.white),
                                    Text(" Dodaj ubranie",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white))
                                  ])
                                ]),
                            color: Colors.teal)),
                  ),
                  ClothesList()
                ],
              ),
            )));
  }
}
