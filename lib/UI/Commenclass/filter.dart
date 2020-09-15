class Filterdetails{
  String district;
  String city;
  String type;
  String variety;

  Filterdetails({this.district,this.city,this.type,this.variety});

  Map filterarr (){

    return {"district":district,"city":city,"type":type,"variety":variety};
  }


}