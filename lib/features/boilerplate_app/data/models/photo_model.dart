class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(
      {required this.id,
      required this.title,
      required this.thumbnailUrl,
      required this.url});

  @override
  String toString() {
    // TODO: implement toString
    return ' id: $id , title: $title , url : $url , thumbnailUrl : $thumbnailUrl';
  }
}
