import 'package:flutter/material.dart';
import 'package:mobizil_app/services/services.dart';
import 'package:mobizil_app/pojo/brand_device_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mobizil_app/ui/brand_details_page.dart';

class BrandDevicesPage extends StatefulWidget {
  final String siteLink;
  final String brandName;

  BrandDevicesPage({this.siteLink, this.brandName});

  @override
  _BrandDevicesPageState createState() => _BrandDevicesPageState();
}

class _BrandDevicesPageState extends State<BrandDevicesPage> {
  Services _services = Services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScopedModel<Services>(
        model: _services,
        child: FutureBuilder(
          future: _services.getBrandDevices(widget.siteLink),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ScopedModelDescendant<Services>(
                builder: (context, child, model) {
                  if (model.getNumberOfDevices != null) {
                    return Container(
                      height: ((model.getNumberOfDevices) * 100).toDouble(),
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        itemCount: model.getNumberOfDevices,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          BrandDevice _brandDevice = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BrandDetailsPage(
                                    brandPageUrl: _brandDevice.getBrandPageLink,
                                    brandDeviceName: '${widget.brandName} ${_brandDevice.getBrandName}',
                                    brandImageUrl: _brandDevice.brandImageUrl,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: Card(
                                elevation: 3,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Container(
                                      height: (MediaQuery.of(context).size.height / 7),
                                      child: Image(
                                        image: NetworkImage(
                                            _brandDevice.getBrandImageUrl),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${widget.brandName} ${_brandDevice.getBrandName}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                        child: Center(child: Text('No Data Found')));
                  }
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
