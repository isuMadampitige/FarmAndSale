import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:login2/Method/buyermethod.dart';

class Staticcharts extends StatefulWidget {
  @override
  _StaticchartsState createState() => _StaticchartsState();
}

class _StaticchartsState extends State<Staticcharts> {
  var sdata;

  List<charts.Series<dynamic, String>> _piedata;
  List<charts.Series<dynamic, String>> _seriesdata;

  //get pie chart details//
  loadstat() {
    var ur3 = 'http://34.87.38.40/chart/district/' +
        _district.text.toString() +
        '/' +
        _type.text.toString() +
        '/' +
        _year.text.toString();
    print(ur3);
    setState(() {
      search = false;
    });
    var url = 'http://34.87.38.40/chart/month/09/potatoes/2019';
    var url2 = 'http://34.87.38.40/chart/month/08/pumkin/2019';
    http.get(ur3).then((response) {
      _piedata = List<charts.Series<dynamic, String>>();
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body == '[]') {
          NoItempopup(context,'No Item Added Under this Category');
        } else {
          var stat = jsonDecode(response.body);
          sdata = stat.map((json) => Staticdata.fromjson(json)).toList();
          print(sdata[0].district);
          _piedata.add(charts.Series(
              data: sdata,
              domainFn: (data, _) => data.month.toString(),
              measureFn: (data, _) => data.addquantity,
              id: 'ststic',
              labelAccessorFn: (data, _) => data.addquantity.toString() + 'Kg',
              colorFn: (data, _) => charts.ColorUtil.fromDartColor(data.clr)));
          setState(() {
            search = true;
          });
        }
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });
  }
//get pie chart details//

//bar chart details//
  loadstat2() {
    var ur3 = 'http://34.87.38.40/chart/month/' +
        _month.text.toString() +
        '/' +
        _typebar.text.toString() +
        '/' +
        _yearbar.text.toString();
    print(ur3);
    setState(() {
      t1search = false;
    });
    var url = 'http://34.87.38.40/chart/month/09/potatoes/2019';
    var url2 = 'http://34.87.38.40/chart/month/08/pumkin/2019';
    http.get(ur3).then((response) {
      _seriesdata = List<charts.Series<dynamic, String>>();
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body == '[]') {
          NoItempopup(context,'No Item Added Under this Category');
        } else {
          var stat = jsonDecode(response.body);
          sdata = stat.map((json) => Staticdata.fromjson(json)).toList();
          print(sdata[0].district);
          _seriesdata.add(
            charts.Series(
                data: sdata,
                domainFn: (data, _) => data.district,
                measureFn: (data, _) => data.addquantity,
                id: 'data1',
                fillPatternFn: (_, __) => charts.FillPatternType.solid,
                fillColorFn: (data, _) =>
                    charts.ColorUtil.fromDartColor(Colors.amber)),
          );
          _seriesdata.add(
            charts.Series(
                data: sdata,
                domainFn: (data, _) => data.district,
                measureFn: (data, _) => data.buyquantity,
                id: 'data1',
                fillPatternFn: (_, __) => charts.FillPatternType.solid,
                fillColorFn: (data, _) =>
                    charts.ColorUtil.fromDartColor(Colors.amber)),
          );
          setState(() {
            t1search = true;
          });
        }
      } else if (response.statusCode == 500) {
        ServerErrorPopup(context);
      } else {
        NetworkErrorPopup(context);
      }
    });
  }

//bar chart details//
  begin() async {
    await loadstat();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //loadstat();
    //begin();
  }

  TextEditingController _district = TextEditingController(text: 'District');
  TextEditingController _month = TextEditingController(text: 'Month');
  TextEditingController _type = TextEditingController(text: 'Type');
  TextEditingController _varietypie = TextEditingController(text: 'All');
  TextEditingController _year = TextEditingController(text: 'Year');

  TextEditingController _typebar = TextEditingController(text: 'Type');
  TextEditingController _varietybar = TextEditingController(text: 'All');
  TextEditingController _yearbar = TextEditingController(text: 'Year');

  //TabController ctrl = TabController(length: 1,initialIndex: 0);

  bool t1search = false;
  bool search = false;
  var districts = [
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Mullaitivu',
    'Vavuniya',
    'Puttalam',
    'Kurunegala',
    'Gampaha',
    'Colombo',
    'Kalutara',
    'Anuradhapura',
    'Polonnaruwa',
    'Matale',
    'Kandy',
    'Nuwara Eliya',
    'Kegalle',
    'Ratnapura'  ,  
    'Trincomalee',
    'Batticaloa',
    'Ampara',
    'Badulla',
    'Monaragala',
    'Hambantota',
    'Matara',
    'Galle',
  ];

  var types = [
    'potato(Raja)',
    'potato(Lyra)',
    'potato(Graenola)',
    'potato(knapsack)',
    'potato(Sante)',
    'potato(Kondor)',
    'potato(Desiree)',
    'potato(Hillstar)'
  ];
  var months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  var years = ['2018', '2019', '2020'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Statistical Data'),
            bottom: TabBar(
              indicatorColor: Colors.amber,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.pie_chart),
                ),
                Tab(
                  icon: Icon(Icons.insert_chart),
                )
              ],
            ),
          ),
          body: TabBarView(
            //controller: ctrl,
            children: <Widget>[
              Center(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'District Harvest',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                          )),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: DropdownButton<String>(
                                      items: districts.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _district.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_district.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                      items: types.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _type.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_type.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButton<String>(
                                      items: years.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _year.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_year.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.grey[300]),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.show_chart,
                                          color: Colors.black,
                                        ),
                                        onPressed: () async {
                                          loadstat();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: !search
                            ? Text(
                                ' Select and Search For the Data',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            : charts.PieChart(
                                _piedata,
                                animate: true,
                                animationDuration: Duration(seconds: 1),
                                behaviors: [
                                  charts.DatumLegend(
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                      horizontalFirst: false,
                                      desiredMaxRows: 2,
                                      cellPadding: EdgeInsets.only(right: 5.0))
                                ],
                                defaultRenderer: charts.ArcRendererConfig(
                                    arcWidth: 100,
                                    arcRendererDecorators: [
                                      charts.ArcLabelDecorator(
                                          labelPosition:
                                              charts.ArcLabelPosition.inside)
                                    ]),
                              ),
                      ),
                    ),
                  ],
                )),
              ),
              Center(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('All Island Harvest',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300)),
                          )),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButton<String>(
                                      items: months.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _month.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_month.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                      items: types.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _typebar.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_typebar.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //flex: 2,
                                    child: DropdownButton<String>(
                                      items: years.map((String dis) {
                                        return DropdownMenuItem<String>(
                                          value: dis,
                                          child: Text(
                                            dis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _yearbar.text = val;
                                        });
                                      },
                                      hint: Row(
                                        children: <Widget>[
                                          Text(_yearbar.text),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: Icon(Icons.show_chart),
                                      onPressed: () async {
                                        loadstat2();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: !t1search
                            ? Text(
                                ' Select and Search For the Data',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            : charts.BarChart(
                                _seriesdata,
                                animate: true,
                                animationDuration: Duration(seconds: 1),
                                barGroupingType: charts.BarGroupingType.grouped,
                              ),
                      ),
                    ),
                  ],
                )),
              )
            ],
          )),
    );
  }
}

class Staticdata {
  String type;
  int month;
  int year;
  String district;
  double addquantity;
  double buyquantity;
  Color clr = Colors.amber.withRed(Random().nextInt(255));

  Staticdata(
      {this.type,
      this.month,
      this.year,
      this.district,
      this.buyquantity,
      this.addquantity});

  factory Staticdata.fromjson(Map<String, dynamic> json) {
    return Staticdata(
        type: json['type'],
        month: json['month'],
        year: json['year'],
        district: json['district'],
        addquantity: json['addquantity'],
        buyquantity: json['buyquantity']);
  }
}
