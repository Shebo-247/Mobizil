class Brand{
  String brandName, brandPageLink;
  int numberOfDevices;

  Brand({this.brandName, this.numberOfDevices, this.brandPageLink});

  String get getBrandName => brandName;
  int get getNumberOfDevices => numberOfDevices;
  String get getBrandPageLink => brandPageLink;
}