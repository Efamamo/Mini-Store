class User {
  final String id;
  final String fullName;
  final String email;
  final Address? address;
  final bool fromProvider;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.address,
    required this.fromProvider,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['userId'].toString(),
      fullName: json['fullName'],
      email: json['email'],
      fromProvider: json['fromProvider'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}

class Address {
  final String latitude;
  final String longitude;
  final String storeName;

  Address({
    required this.latitude,
    required this.longitude,
    required this.storeName,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: json['latitude'],
      longitude: json['longitude'],
      storeName: json['storeName'],
    );
  }
}
