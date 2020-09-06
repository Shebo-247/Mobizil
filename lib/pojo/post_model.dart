class Post{
  String postTitle, postImageUrl, postLink;

  Post.from({this.postTitle, this.postImageUrl, this.postLink});
  Post();

  String get getPostTitle => postTitle;
  String get getPostImageUrl => postImageUrl;
  String get getPostLink => postLink;
}