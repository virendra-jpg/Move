import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moving_proj/main.dart';
import 'package:moving_proj/trackTruck.dart';

class TrackLoad extends StatefulWidget {
  final Map<String, Object>? loadDetails;
  const TrackLoad({Key? key, required this.loadDetails}) : super(key: key);

  @override
  State<TrackLoad> createState() => _TrackLoadState();
}

class _TrackLoadState extends State<TrackLoad> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 20,),
              _appbar(),
              _body()
            ],
          ),
        ),
      ),
    );
  }
  Widget _appbar(){
    return Container(
        child:Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black),onPressed: () {
              Navigator.pop(context);
            }),
            SizedBox(width: 20,),
            Text("Track Load",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
          ],
        )
    );
  }
  Widget _body(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pickup Location",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
                  Text("${widget.loadDetails?["pickupLocation"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
                  SizedBox(height: 20,),
                  Text("Drop Location",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
                  Text("${widget.loadDetails?["dropOffLocation"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),)
                ],
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.2),
                ),
                width: 100,
              )
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Truck Fare",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
              Text("${widget.loadDetails?["fare"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Distance",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
              Text("${widget.loadDetails?["distance"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weight of Load",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
              Text("${widget.loadDetails?["weight"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),),
            ],
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
              Text("${widget.loadDetails?["amount"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
            ],
          ),
          SizedBox(height: 50,),
          Text("Truck Detail",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
          Column(
            children: _cards(widget.loadDetails!),
          ),
        ],
      ),
    );

  }

  List<Widget> _cards(Map<String, Object> data)  {
    List<dynamic> status = json.decode(json.encode(data["status"]).toString());
    print(status);
    return status.map((element) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TrackTruck(loadDetails: widget.loadDetails, truckDetails: element,)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 50,width: 50,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.black.withOpacity(0.2),
              ),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Driver Name: ${element["driverName"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
                  Text("Truck No: ${element["truckNo"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14),)
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TrackTruck(loadDetails: widget.loadDetails, truckDetails: element,)));
                },
                child: Center(
                  child: Text("Check Status",style: TextStyle(color: Colors.white),),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

}