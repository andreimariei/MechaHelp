class Service {
  String name;
  String city;
  String address;
  String category;
  String price;
  String imgUrl;
  String description;
  double lat;
  double long;
  String phone;

  Service(this.name, this.city, this.address, this.category, this.price,
      this.imgUrl, this.description, this.lat, this.long, this.phone);

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        json['name'],
        json['city'],
        json['address'],
        json['category'],
        json['price'],
        json['imgUrl'],
        json['description'],
        json['location'].latitude,
        json['location'].longitude,
        json['phone']);
  }

  Map toJson() => {
        'name': name,
        'city': city,
        'address': address,
        'category': category,
        'price': price,
        'imgUrl': imgUrl,
        'description': description,
        'location': [lat, long],
        'phone': phone
      };
}
