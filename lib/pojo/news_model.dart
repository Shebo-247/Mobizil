class News{
  final String url, imageUrl, title, description, date; 

  News({this.url, this.imageUrl, this.title, this.description, this.date});

  String get getUrl => this.url;
  String get getImageUrl => this.imageUrl;
  String get getTitle => this.title;
  String get getDescription => this.description;
  String get getDate => this.date;
}