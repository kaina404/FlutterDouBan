class MovieBean {
  Rating rating;
  var genres;
  var title;
  var casts;
  var collect_count;
  var original_title;
  var subtype;
  var directors;
  var year;
  Images images;
  var alt;
  var id;

  ///构造函数
  MovieBean.fromMap(Map<String, dynamic> map) {
    var rating = map['rating'];
    this.rating = Rating(rating['average'], rating['max']);
    genres = map['genres'];
    title = map['title'];
    casts = map['casts'];
    collect_count = map['collect_count'];
    original_title = map['original_title'];
    subtype = map['subtype'];
    directors = map['directors'];
    year = map['year'];
    var img = map['images'];
    images = Images(img['small'], img['large'], img['medium']);
    alt = map['alt'];
    id = map['id'];
  }
}

class Images {
  var small;
  var large;
  var medium;

  Images(this.small, this.large, this.medium);
}

class Rating {
  var average;
  var max;
  Rating(this.average, this.max);
}
