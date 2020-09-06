class BrandDevice{
  String brandImageUrl, brandName, brandPageLink;

  BrandDevice({this.brandImageUrl, this.brandName, this.brandPageLink});

  String get getBrandImageUrl => brandImageUrl;
  String get getBrandName => brandName;
  String get getBrandPageLink => brandPageLink;
}