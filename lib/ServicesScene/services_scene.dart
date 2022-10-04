import 'dart:core';

import 'package:MechaHelp/Model/Service.dart';
import 'package:MechaHelp/Service/FirebaseService.dart';
import 'package:MechaHelp/ServicesScene/service_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesScene extends StatefulWidget {
  static Color backgroundColor = Colors.orange;
  static Color highlightColor = Colors.orangeAccent;
  static Color unselectedColor = Colors.deepOrange;
  static Color accentColor = Color(0xFFDABBA7);
  static Color textDarkColor = Color(0xFF5E5E5E);
  static Color textLightColor = Color(0xFFC4C4C4);

  @override
  _ServicesSceneState createState() => _ServicesSceneState();
}

class _ServicesSceneState extends State<ServicesScene> {
  List<String> categories = [];
  int selectedCategories = 0;
  String searchedService = "";
  List<Service> services = [];

  @override
  Widget build(BuildContext context) {
    FirebaseService serv = Provider.of<FirebaseService>(context, listen: false);
    services = serv.getServices();
    categories = ["All"] + (serv.getCategories(services));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Service-uri",
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        backgroundColor: ServicesScene.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: ServicesScene.backgroundColor,
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextField(
                  onChanged: (text) {
                    searchedService = text;
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: ServicesScene.highlightColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ServicesScene.highlightColor),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ServicesScene.highlightColor),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ServicesScene.highlightColor),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.white, size: 28),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return index == selectedCategories
                            ? selectedCategoryCard(categories[index])
                            : unselectedCategoryCard(categories[index], index);
                      }),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              height: getDividerHeight(index),
                              color: Colors.transparent,
                            ),
                        padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return getServiceCard(index);
                        })
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget selectedCategoryCard(String category) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: ServicesScene.highlightColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget unselectedCategoryCard(String category, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategories = index;
        });
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                  color: ServicesScene.unselectedColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget getServiceCard(int index) {
    if (selectedCategories != 0) {
      if (services[index].category.toLowerCase() ==
          categories[selectedCategories].toLowerCase()) {
        if (searchedService == "")
          return ServicesCard(services[index]);
        else {
          if (services[index]
              .city
              .toLowerCase()
              .contains(searchedService.toLowerCase()))
            return ServicesCard(services[index]);
          else
            return SizedBox();
        }
      } else
        return SizedBox();
    } else {
      if (searchedService == "") {
        return ServicesCard(services[index]);
      } else {
        if (services[index]
            .city
            .toLowerCase()
            .contains(searchedService.toLowerCase()))
          return ServicesCard(services[index]);
        else
          return SizedBox();
      }
    }
  }

  double getDividerHeight(int index) {
    if (selectedCategories == 0)
      return 5;
    else {
      if (services[index].category == categories[selectedCategories])
        return 5;
      else
        return 0;
    }
  }
}
