extension StringExt on String {
  String get imageURL {
    return 'https://images.igdb.com/igdb/image/upload/t_original/$this.jpg';
  }
}
