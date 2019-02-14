class SubjectEntity {

//  "subject":Object{...},
//  "rank":1,
//  "delta":0

  Subject subject;
  var rank;
  var delta;

  SubjectEntity.fromMap(Map<String, dynamic> map){
    rank = map['rank'];
    delta = map['delta'];
    var subjectMap = map['subject'];
    subject = Subject.fromMap(subjectMap);
  }
}

class Subject {
  bool tag = false;
  Rating rating;
  var genres;
  var title;
  List<Cast> casts;
  var durations;
  var collect_count;
  var mainland_pubdate;
  var has_video;
  var original_title;
  var subtype;
  var directors;
  var pubdates;
  var year;
  Images images;
  var alt;
  var id;

  ///构造函数
  Subject.fromMap(Map<String, dynamic> map) {
    var rating = map['rating'];
    this.rating = Rating(rating['average'], rating['max']);
    genres = map['genres'];
    title = map['title'];
    var castMap = map['casts'];
    casts = _converCasts(castMap);
    collect_count = map['collect_count'];
    original_title = map['original_title'];
    subtype = map['subtype'];
    directors = map['directors'];
    year = map['year'];
    var img = map['images'];
    images = Images(img['small'], img['large'], img['medium']);
    alt = map['alt'];
    id = map['id'];
    durations = map['durations'];
    mainland_pubdate = map['mainland_pubdate'];
    has_video = map['has_video'];
    pubdates = map['pubdates'];
  }

  _converCasts(casts) {
    return casts.map<Cast>((item)=>Cast.fromMap(item)).toList();
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



class Cast {
  var id;
  var name_en;
  var name;
  Avatar avatars;
  var alt;
  Cast(this.avatars, this.name_en, this.name, this.alt, this.id);

  Cast.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name_en = map['name_en'];
    name = map['name'];
    alt = map['alt'];
    var tmp = map['avatars'];
    if(tmp == null){
      avatars = null;
    }else{
      avatars = Avatar(tmp['small'], tmp['large'], tmp['medium']);
    }

  }
}

class Avatar {
  var medium;
  var large;
  var small;
  Avatar(this.small, this.large, this.medium);
}
