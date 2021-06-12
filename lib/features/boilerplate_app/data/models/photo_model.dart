

class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.id, this.title,this.thumbnailUrl,this.url});


  @override
  String toString() {
    // TODO: implement toString
    return  ' id: $id , title: $title , url : $url , thumbnailUrl : $thumbnailUrl' ;
  }

}