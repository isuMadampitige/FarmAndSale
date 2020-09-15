import 'package:login2/userclass.dart';

class Vehicle {
  int vehicle_id;
  String brand;
  String reg_number;
  String vehicle_number;
  int insurance_number;
  Usr transporter;
  bool isApproved;

  Vehicle(
      {this.vehicle_id,
      this.vehicle_number,
      this.brand,
      this.reg_number,
      this.insurance_number,
      this.transporter,
      this.isApproved});

  factory Vehicle.fromjson(Map<String, dynamic> json) {
    return Vehicle(
      vehicle_id: json['vehicle_id'],
      brand: json['brand'],
      reg_number: json['reg_number'],
      vehicle_number: json['vehicle_number'],
      insurance_number: json['insurance_number'],
      transporter: Usr.fromJsontransporter(json['transporter']),
      isApproved: json['isApproved'],
    );
  }
}
