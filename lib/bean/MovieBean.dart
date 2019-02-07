class MovieBean {
  var rating;
  var genres;
  var title;
  var casts;
  var collect_count;
  var original_title;
  var subtype;
  var directors;
  var year;
  var images;
  var alt;
  var id;

  MovieBean.fromMap(Map<String, dynamic> map) {
    rating = map['rating'];
    genres = map['genres'];
    title = map['title'];
    casts = map['casts'];
    collect_count = map['collect_count'];
    original_title = map['original_title'];
    subtype = map['subtype'];
    directors = map['directors'];
    year = map['year'];
    images = map['images'];
    alt = map['alt'];
    id = map['id'];
  }
}
