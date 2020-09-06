import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:mobizil_app/pojo/news_model.dart';
import 'package:mobizil_app/pojo/post_model.dart';
import 'package:mobizil_app/pojo/brand_model.dart';
import 'package:mobizil_app/pojo/brand_device_model.dart';
import 'package:mobizil_app/pojo/device_details_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Services extends Model {
  static const String BASE_SITE_URL = 'https://www.gsmarena.com';
  static const String NEWS_SITE_URL = '$BASE_SITE_URL/news.php3';
  static const String BRANDS_SITE_URL = '$BASE_SITE_URL/makers.php3';

  List<News> news = [];
  List<Post> posts = [];
  List<Brand> brands = [];
  List<BrandDevice> brandDevices = [];

  Map<String, String> device = {};
  DeviceDetails deviceDetails = DeviceDetails();

  //= For global variables =//
  int _numberOfDevices;

  int get getNumberOfDevices => _numberOfDevices;

  void setNumberOfDevices(int number) {
    _numberOfDevices = number;
    notifyListeners();
  }

  /////////////////////////

  Future getAllNews() async {
    print('CALL GET ALL NEWS');

    http.Response response = await http.get(NEWS_SITE_URL);

    dom.Document document = parser.parse(response.body);

    document.getElementsByClassName('news-item').forEach((child) {
      // get new url
      var start = child
          .getElementsByClassName('news-item-media-wrap')
          .first
          .innerHtml
          .indexOf('href');
      var end = child
          .getElementsByClassName('news-item-media-wrap')
          .first
          .innerHtml
          .indexOf('php');
      var newsUrl = child
          .getElementsByClassName('news-item-media-wrap')
          .first
          .innerHtml
          .substring(start + 6, end + 3);
      // to getimage url
      var lastIndex = child
          .getElementsByClassName('news-item-media-wrap')
          .first
          .children
          .first
          .innerHtml
          .indexOf('alt');
      var newsImageUrl = child
          .getElementsByClassName('news-item-media-wrap')
          .first
          .children
          .first
          .innerHtml
          .substring(15, lastIndex - 2);
      // get new title
      var newsTitle = child.getElementsByTagName('h3').first.text;

      // get news time
      var date = child.getElementsByClassName('meta-item-time').first.text;

      news.add(
        News(
            url: newsUrl,
            title: newsTitle,
            imageUrl: newsImageUrl,
            description: '',
            date: date),
      );
    });
    return news;
  }

  Future getAllPosts() async {
    print('CALL GET ALL POSTS');

    http.Response response = await http.get(BASE_SITE_URL);

    dom.Document document = parser.parse(response.body);

    document.getElementsByClassName('feat-item').forEach((child) {
      // get post title
      var postTitle =
          child.getElementsByClassName('feat-item-header').first.text;
      // to get post image url
      int first = child
          .getElementsByClassName('feat-item-image')
          .first
          .outerHtml
          .indexOf('url');
      int last = child
          .getElementsByClassName('feat-item-image')
          .first
          .outerHtml
          .indexOf('jpg');

      var postImageUrl = child
          .getElementsByClassName('feat-item-image')
          .first
          .outerHtml
          .substring(first + 5, last + 3);
      // get post link
      int start = child
          .getElementsByClassName('feat-item-link')
          .first
          .outerHtml
          .indexOf('href');
      int end = child
          .getElementsByClassName('feat-item-link')
          .first
          .outerHtml
          .indexOf('php');
      var postLink = child
          .getElementsByClassName('feat-item-link')
          .first
          .outerHtml
          .substring(start + 6, end + 3);

      posts.add(Post.from(
        postTitle: postTitle,
        postImageUrl: postImageUrl,
        postLink: postLink,
      ));
    });

    return posts;
  }

  Future getAllBrands() async {
    print('CALL GET ALL BRANDS');
    http.Response response = await http.get(BRANDS_SITE_URL);

    dom.Document document = parser.parse(response.body);

    document.getElementsByTagName('tr').forEach((child) {
      // Get Brand Name
      int last =
          child.getElementsByTagName('a').first.innerHtml.indexOf('<br>');
      String brandName =
          child.getElementsByTagName('a').first.innerHtml.substring(0, last);

      // Get Number Of Devices
      String data = child
          .getElementsByTagName('a')
          .first
          .getElementsByTagName('span')
          .first
          .text;

      int index = data.indexOf('devices');
      int numberOfDevices = int.parse(data.substring(0, index - 1));

      // Get Brand Page Link
      int start =
          child.getElementsByTagName('a').first.outerHtml.indexOf('href');
      int end = child.getElementsByTagName('a').first.outerHtml.indexOf('php');
      String brandPageLink = child
          .getElementsByTagName('a')
          .first
          .outerHtml
          .substring(start + 6, end + 3);
      brands.add(
        Brand(
            brandName: brandName,
            numberOfDevices: numberOfDevices,
            brandPageLink: brandPageLink),
      );
    });

    return brands;
  }

  Future getBrandDevices(String url) async {
    print('CALL GET BRAND DEVICES');

    http.Response response = await http.get('$BASE_SITE_URL/$url');
    dom.Document document = parser.parse(response.body);

    document
        .getElementsByClassName('makers')
        .first
        .getElementsByTagName('ul')
        .first
        .getElementsByTagName('li')
        .forEach((child) {
      // Get Brand Image Url
      int first =
          child.getElementsByTagName('a').first.innerHtml.indexOf('src');
      int last = child.getElementsByTagName('a').first.innerHtml.indexOf('jpg');
      String brandImageUrl = child
          .getElementsByTagName('a')
          .first
          .innerHtml
          .substring(first + 5, last + 3);

      // Get Brand Name
      String brandName = child
          .getElementsByTagName('a')
          .first
          .getElementsByTagName('strong')
          .first
          .text;

      // Get Brand Device Page Link
      int start =
          child.getElementsByTagName('a').first.outerHtml.indexOf('href');
      int end = child.getElementsByTagName('a').first.outerHtml.indexOf('php');
      String brandPageLink = child
          .getElementsByTagName('a')
          .first
          .outerHtml
          .substring(start + 6, end + 3);

      brandDevices.add(
        BrandDevice(
          brandImageUrl: brandImageUrl,
          brandName: brandName,
          brandPageLink: brandPageLink,
        ),
      );
    });

    setNumberOfDevices(brandDevices.length);

    return brandDevices;
  }

  Future getDeviceDetails(String url) async {
    print('CALL GET DEVICE DETAILS');
    print('$BASE_SITE_URL/$url');
    http.Response response = await http.get('$BASE_SITE_URL/$url'.trim());
    dom.Document document = parser.parse(response.body);

    bool notSingleCamera = false;

    document.getElementById('specs-list').getElementsByTagName('tr').forEach((child) {
      if (child.innerHtml.contains('<td')){
        String s1 = child.getElementsByClassName('ttl').first.text.trim();
        if (s1 == 'Quad' || s1 == 'Triple' || (s1 == 'Dual' && !device.keys.contains('Quad'))){
          s1 = 'camera';
          notSingleCamera = true;
        }
        String s2 = child.getElementsByClassName('nfo').first.text.trim();

        device.addAll({s1: s2});
      }
    });

    deviceDetails = DeviceDetails(
      os: device['OS'],
      chipset: '- ${device['Chipset']}\n- ${device['CPU']}',
      internalMemory: device['Internal'],
      camera: notSingleCamera ? device['camera'] : device['Single'],
      display: '- ${device['Type']}\n- ${device['Size']}',
      battery: device[''],
      price: device['Price'],
    );

    return deviceDetails;
  }
}
