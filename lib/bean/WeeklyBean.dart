class WeeklyBean {

//  "subject":Object{...},
//  "rank":1,
//  "delta":0

  Subject subject;
  var rank;
  var delta;

  WeeklyBean.fromMap(Map<String, dynamic> map){
    rank = map['rank'];
    delta = map['delta'];
    var subjectMap = map['subject'];
    subject = Subject.fromMap(subjectMap);
  }
}

class Subject {
  var rating;
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

  Subject.fromMap(Map<String, dynamic> map) {
    rating = map['rating'];
    genres = map['genres'];
    title = map['title'];
    var castMap = map['casts'];
    casts = converCasts(castMap);
    durations = map['durations'];
    collect_count = map['collect_count'];
    mainland_pubdate = map['mainland_pubdate'];
    has_video = map['has_video'];
    original_title = map['original_title'];
    subtype = map['subtype'];
    directors = map['directors'];
    pubdates = map['pubdates'];
    year = map['year'];
    var img = map['images'];
    images = Images(img['small'], img['large'], img['medium']);
    alt = map['alt'];
    id = map['id'];
  }

  converCasts(casts) {
    return casts.map<Cast>((item)=>Cast.fromMap(item)).toList();
  }
}

class Images {
  var small;
  var large;
  var medium;

  Images(this.small, this.large, this.medium);
}

//"avatars":{
//"small":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1860.webp",
//"large":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1860.webp",
//"medium":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1860.webp"
//},
//"name_en":"Rami Malek",
//"name":"拉米·马雷克",
//"alt":"https://movie.douban.com/celebrity/1044903/",
//"id":"1044903"

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
    avatars = Avatar(tmp['small'], tmp['large'], tmp['medium']);
  }
}

class Avatar {
  var medium;

  var large;

  var small;

  Avatar(this.small, this.large, this.medium);
}
