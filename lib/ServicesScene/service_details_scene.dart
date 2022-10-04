import 'dart:async';
import 'dart:ui';

import 'package:MechaHelp/Model/Service.dart';
import 'package:MechaHelp/Service/FirebaseService.dart';
import 'package:MechaHelp/ServicesScene/services_scene.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/Review.dart';
class ServiceDetails extends StatefulWidget {
  Service product;

  ServiceDetails(this.product);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}


class _ServiceDetailsState extends State<ServiceDetails> {
  late TextEditingController notaController = TextEditingController();
  num? rating=5;
  List<Review> _allReviews=[];
  late FirebaseService service= FirebaseService();
  double getMedieRating() {
    if (_allReviews.isEmpty) {
      return 0;
    }
    double suma = 0;
    _allReviews.forEach((element) {
      suma += double.parse(element.stars.toString());
    });
    double medie = suma / _allReviews.length;
    return medie;
  }
  @override
  void initState()
  {
    service.getReviewsFromFirebase(widget.product.name).then((value) {
      _allReviews=service.getReviews();
      setState(() {
        rating = getMedieRating();
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ServicesScene.accentColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.bookmark_border,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        color: ServicesScene.accentColor,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Hero(
                    tag: widget.product.name,
                    child: Image.network(
                      widget.product.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
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
                          flex: 5,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      height: 100,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        widget.product.city+"\n"+widget.product.address,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                        child: Image.asset('images/map.png'),
                                        onPressed: () async {
                                          MapUtils.openMap(widget.product.lat,
                                              widget.product.long);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26)),
                            margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          ),
                        ),
                        SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(42, 16, 32, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: Text(
                                  widget.product.description,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Card(
                          color: ServicesScene.backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 36, right: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(60),
                                    ),
                                    if (widget.product.price.toLowerCase() ==
                                        'low')
                                      Text(
                                        "Preturi:\$",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    if (widget.product.price.toLowerCase() ==
                                        'medium')
                                      Text(
                                        "Preturi:\$\$",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    if (widget.product.price.toLowerCase() ==
                                        'high')
                                      Text(
                                        "Preturi:\$\$\$",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    SizedBox(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(100),
                                    ),
                                    StarRating(rating:rating, color: ServicesScene.unselectedColor,)
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(40),
                                    ),
                                    FlatButton(
                                      color: ServicesScene.unselectedColor,
                                      padding:
                                          EdgeInsets.fromLTRB(62, 16, 62, 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      onPressed: () {
                                        launch("tel://" + widget.product.phone);
                                      },
                                      child: Text(
                                        "Suna",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(40),
                                    ),
                                    FlatButton(
                                      color: ServicesScene.unselectedColor,
                                      padding:
                                      EdgeInsets.fromLTRB(62, 16, 62, 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      onPressed: () {
                                        _leaveReviewDialog();
                                      },
                                      child: Text(
                                        "Da rating",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future openDialog() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Da o nota'),
          content: TextField(
            autofocus: true,
            controller: notaController,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(notaController.text);
                },
                child: Text('Confirma'))
          ],
        ),
      );
  _leaveReviewDialog() async {
    TextEditingController controllerStars = TextEditingController();
    TextEditingController controllerReview = TextEditingController();
    AutovalidateMode autovalideMode = AutovalidateMode.disabled;
    final GlobalKey<FormState> reviewFormKey = GlobalKey();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: AlertDialog(
            title:
                 Text(
              "Lasa o recenzie",
              style: TextStyle(color: Colors.white),
            ),
            content: Container(
              child: Form(
                key: reviewFormKey,
                autovalidateMode: autovalideMode,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 5, top: 10, bottom: 5),
                        child: Text(
                          'Introduceti un numar intre 1 si 5',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          color: ServicesScene.unselectedColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        controller: controllerStars,
                        validator: (String? value) {
                          int? nota = int.tryParse(value!);
                          if (nota == null || nota < 1 || nota > 5) {
                            return 'Introduceti un numar intreg de la 1 la 5';
                          }
                        },
                        onChanged: (String? val) {
                          controllerStars.text = val!;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 5, top: 10, bottom: 5),
                        child: Text(
                          'Recenzie',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          color: ServicesScene.unselectedColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: height / 5 - 10,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            controller: controllerReview,
                            maxLines: null,
                            onChanged: (String? val) {},
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: ServicesScene.backgroundColor,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )),
                onPressed: () {
                  reviewFormKey.currentState?.reset();
                  Navigator.pop(context);
                },
                child: const Text("Inapoi"),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    if (reviewFormKey.currentState!.validate()) {
                      reviewFormKey.currentState?.save();
                      Review myReview = Review.fromMap({
                        'stars': int.parse(controllerStars.text),
                        'idService': widget.product.name,
                        'content': controllerReview.text,
                      });
                      try {
                        await FirebaseFirestore.instance
                            .collection('reviews')
                            .add(myReview.toMap());
                          Fluttertoast.showToast(
                              msg: "Review submis!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        _allReviews.add(myReview);
                        reviewFormKey.currentState?.reset();
                        setState(() {
                          rating = getMedieRating();
                        });
                        Navigator.pop(context);
                      } on Exception catch (e) {
                        Fluttertoast.showToast(
                            msg: "Esec!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red.withOpacity(0.7),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      setState(() {
                        autovalideMode = AutovalidateMode.always;
                      });
                    }
                  },
                  child: const Text("Finalizare")),
            ],
          ),
        );
      },
    );
  }

}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
class StarRating extends StatelessWidget {
  final int? starCount;
  final num ?rating;
  final Color? color;
  final MainAxisAlignment? rowAlignment;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.color,
    this.rowAlignment = MainAxisAlignment.center,
  });

  Widget buildStar(
      BuildContext context, int rank, MainAxisAlignment rowAlignment) {
    Icon icon;
    if (rank >= rating!) {
      return icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (rank > rating! - 1 && rank < rating!) {
      return icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      return icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: rowAlignment!,
      children: new List.generate(
        starCount!,
            (rank) => buildStar(context, rank, rowAlignment!),
      ),
    );
  }
}

