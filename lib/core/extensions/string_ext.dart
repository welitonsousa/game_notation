extension StringExt on String {
  String get imageURL {
    return 'https://images.igdb.com/igdb/image/upload/t_original/$this.jpg';
  }

  String get imageThumbURL {
    return 'https://images.igdb.com/igdb/image/upload/t_thumb/$this.jpg';
  }

  String get imageCoverURL {
    return 'https://images.igdb.com/igdb/image/upload/t_cover_big/$this.jpg';
  }
}
