class Usr {
  String token;
  int farmer_id;
  String district;
  int id;
  String fullname;
  String address;
  String nic;
  String mobilenumber;
  double starcount;
  String license;
  String email;
  bool confirmed;

  Usr(
      {this.token,
      this.farmer_id,
      this.id,
      this.fullname,
      this.address,
      this.nic,
      this.mobilenumber,
      this.district,
      this.starcount,
      this.license,
      this.email,
      this.confirmed});

  factory Usr.fromJson(Map<String, dynamic> json) {
    if (json['buyer_id'] != null) {
      return Usr(
          id: (json['buyer_id']),
          fullname: json['full_name'],
          address: json['address'],
          //nic:json['nic'],
          starcount: json['rate'],
          mobilenumber: json['mobile_number'],
          district: json['district']);
    } else if (json['farmer_id'] != null) {
      return Usr(
          id: (json['farmer_id']),
          fullname: json['full_name'],
          address: json['address'],
          //nic:json['nic'],
          starcount: json['rate'],
          mobilenumber: json['mobile_number'],
          district: json['district'],
          confirmed: json['confirmed']);
    } else if (json['transporter_id'] != null) {
      return Usr(
          id: (json['transporter_id']),
          fullname: json['full_name'],
          address: json['address'],
          //nic:json['nic'],
          starcount: json['rate'],
          mobilenumber: json['mobile_number'],
          district: json['district']);
    }
  }

  factory Usr.fromJsonbuyer(Map<String, dynamic> json) {
    return Usr(
        id: (json['buyer_id']),
        fullname: json['full_name'],
        address: json['address'],
        district: json['district'],
        starcount: json['rate'],
        mobilenumber: json['mobile_number']);
  }

  factory Usr.fromJsonfarmer(Map<String, dynamic> json) {
    return Usr(
        id: (json['farmer_id']),
        fullname: json['full_name'],
        address: json['address'],
        nic: json['nic'],
        starcount: json['rate'],
        mobilenumber: json['mobile_number'],
        district: json['district']);
  }

  factory Usr.fromJsontransporter(Map<String, dynamic> json) {
    return Usr(
        id: (json['transporter_id']),
        fullname: json['full_name'],
        address: json['address'],
        district: json['district'],
        starcount: json['rate'],
        mobilenumber: json['mobile_number'],
        license: json['license'],
        email: json['email']);
  }

  factory Usr.fromjsonfull(Map<String, dynamic> json) {
    return Usr(
      token: json['token'],
    );
  }
}
