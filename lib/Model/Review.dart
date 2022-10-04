class Review {

  static const colIdService = 'idService';
  static const colContent = 'content';
  static const colStars = 'stars';

  num? stars;
  String? idService,  content;
  Review({this.idService, this.content, this.stars});

  Review.fromMap(Map <dynamic, dynamic> map)
  {
    idService = map[colIdService];
    content = map[colContent];
    stars = map[colStars];

  }

  Map <String, dynamic> toMap() {
    var map = <String, dynamic> {
      'idService': idService,
      'stars': stars,
      'content':content,

    };
    return map;
  }
}