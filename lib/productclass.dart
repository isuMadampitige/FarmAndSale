class Product{
  String category;
  String type;
  String quantity;
  //String price;
  String location;
  String exp_date;


Product({
  this.category,
  this.quantity,
  this.type,
  this.exp_date,
  this.location
});

factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        category: (json['category']),
        quantity: json['quantity'],
        type: json['type'],
        exp_date:json['exp_date'],
        location:json['location']);
  }
}