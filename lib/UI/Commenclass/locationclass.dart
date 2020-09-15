
class Locatin{
        
  String latitude;
  String longitude;
  int location_id;
        
  Locatin({
           
    this.latitude,
    this.longitude,
    this.location_id
  });
        
factory Locatin.fromJson(Map<String, dynamic> json) {
  return Locatin(
    longitude: json['longitude'],
    latitude: json['latitude'],
    location_id: json['location_id'],
    );
  }
}