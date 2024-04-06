import 'package:flutter/material.dart';
import 'package:skl/RealState/HouseFlat.dart';
import 'package:skl/RealState/OfficeSpace.dart';
import 'package:skl/RealState/PgGuest.dart';
import 'package:skl/RealState/ShopsWarehouse.dart';

class RealEstateType extends StatelessWidget {
  const RealEstateType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Estate Types'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Real State, Plot & Properties',
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildButton(context, 'House, Flats & Apartments', HouseFlat()),
                    const SizedBox(height: 10.0),
                    _buildButton(context, 'Shops & Warehouse', ShopsWarehouse()),
                    const SizedBox(height: 10.0),
                    _buildButton(context, 'Office Space', OfficeSpace()),
                    const SizedBox(height: 10.0),
                    _buildButton(context, 'PG & Guest House', PgGuestHouse()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String buttonText, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}




