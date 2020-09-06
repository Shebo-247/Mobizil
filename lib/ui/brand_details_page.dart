import 'package:flutter/material.dart';
import 'package:mobizil_app/pojo/device_details_model.dart';
import 'package:mobizil_app/services/services.dart';

class BrandDetailsPage extends StatefulWidget {
  final String brandPageUrl, brandDeviceName, brandImageUrl;

  BrandDetailsPage(
      {this.brandPageUrl, this.brandDeviceName, this.brandImageUrl});

  @override
  _BrandDetailsPageState createState() => _BrandDetailsPageState();
}

class _BrandDetailsPageState extends State<BrandDetailsPage> {
  Services _services = Services();
  var price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandDeviceName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: FutureBuilder(
        future: _services.getDeviceDetails(widget.brandPageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            DeviceDetails _deviceDetails = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              color: Colors.red,
              child: Center(
                child: Text(
                  'Price ${_deviceDetails.getPrice}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
      body: FutureBuilder(
        future: _services.getDeviceDetails(widget.brandPageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            DeviceDetails _deviceDetails = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.brandImageUrl),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  createFeatureCard(Icons.code, 'OS', _deviceDetails.getOS),
                  createFeatureCard(Icons.storage, 'Storage',
                      _deviceDetails.getInternalMemory),
                  createFeatureCard(
                      Icons.memory, 'CPU', _deviceDetails.getChipset),
                  createFeatureCard(
                      Icons.touch_app, 'Display', _deviceDetails.getDisplay),
                  createFeatureCard(
                      Icons.camera, 'Camera', _deviceDetails.getCamera),
                  createFeatureCard(
                      Icons.battery_full, 'Battery', _deviceDetails.getBattery),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget createFeatureCard(icon, title, feature) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(feature),
      ),
    );
  }
}
