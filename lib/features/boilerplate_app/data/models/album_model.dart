class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  @override
  String toString() {
    // TODO: implement toString
    return ' id: $id , title: $title';
  }
}
