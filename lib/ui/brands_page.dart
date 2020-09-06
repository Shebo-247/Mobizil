import 'package:flutter/material.dart';
import 'package:mobizil_app/services/services.dart';
import 'package:mobizil_app/pojo/brand_model.dart';
import 'package:mobizil_app/pojo/brand_device_model.dart';
import 'package:mobizil_app/ui/brand_devices_page.dart';

class BrandsPage extends StatefulWidget {
  @override
  _BrandsPageState createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  Services services = Services();
  
  Widget displayAllBrands() {
    return FutureBuilder(
      future: services.getAllBrands(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: 58,
            itemBuilder: (context, index) {
              Brand brand = snapshot.data[index];
              return GestureDetector(
                onTap: () {
                  //getBrandDevicesNumber(brand.brandPageLink);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BrandDevicesPage(
                        siteLink: brand.brandPageLink,
                        brandName: brand.getBrandName,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            brand.getBrandName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              '${brand.getNumberOfDevices} devices',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: displayAllBrands(),
    );
  }
}
