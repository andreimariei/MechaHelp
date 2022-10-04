import 'package:MechaHelp/Model/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/Review.dart';

class FirebaseService {
  FirebaseFirestore? _instance;

  List<Service> _services = [];
  List<Review> _reviews = [];
  List<Service> getServices() {
    return _services;
  }
  List<Review> getReviews()
  {
    return _reviews;
  }

  List<String> getCategories(List<Service> serv) {
    List<String> categs = [];
    for (int i = 0; i < serv.length; i++) {
      if (!categs.contains(serv[i].category)) {
        categs.add(serv[i].category);
      }
    }
    return categs;
  }

  Future<void> updateDB(List<Service> serv) async {
    _instance = FirebaseFirestore.instance;

    CollectionReference services = _instance!.collection('services');

    DocumentSnapshot snapshot = await services.doc('collection').get();

    var data = snapshot.data() as Map;
    var categData = data['collection'] as List<dynamic>;
    categData.removeRange(0, categData.length);

    serv.forEach((elem) {
      categData.add(elem.toJson());
    });
  }
  Future<void> getReviewsFromFirebase(String? serviceName) async {
    _instance = FirebaseFirestore.instance;
    _reviews = [];
    CollectionReference collectionReference = _instance!.collection('reviews');
    QuerySnapshot querySnapshot =
    await collectionReference.where("idService", isEqualTo: serviceName).get();
    int nr = 0;
    querySnapshot.docs.forEach((element) {
      Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
      if (data != null) {
        print(data);
        final Review serviceReview = Review.fromMap({
          'idService': data['idService'],
          'content': data['content'],
          'stars': data['stars'],
        });
        _reviews.add(serviceReview);
      }
    });
  }
  Future<void> getServicesFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference services = _instance!.collection('services');

    DocumentSnapshot snapshot = await services.doc('collection').get();

    var data = snapshot.data() as Map;
    var categData = data['collection'] as List<dynamic>;

    categData.forEach((catData) {
      _services.add(Service.fromJson(catData));
    });
  }
}
