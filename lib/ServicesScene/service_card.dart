import 'package:MechaHelp/Model/Service.dart';
import 'package:MechaHelp/ServicesScene/service_details_scene.dart';
import 'package:MechaHelp/ServicesScene/services_scene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  Service product;

  ServicesCard(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => ServiceDetails(product)));
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Card(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
              color: ServicesScene.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            elevation: 10,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(
                              color: ServicesScene.textDarkColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.city,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ServicesScene.textLightColor,
                              fontSize: 16),
                        ),
                        Text(
                          product.address,
                          style: TextStyle(
                              color: ServicesScene.textLightColor,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.category,
                          style: TextStyle(
                              color: ServicesScene.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 125,
                        minHeight: 125,
                      ),
                      child: Hero(
                        tag: product.name,
                        child: Image.network(
                          product.imgUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
