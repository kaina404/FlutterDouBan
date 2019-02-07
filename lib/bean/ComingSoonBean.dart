//{"count": 1, "start": 0, "total": 43, "subjects":
//[{"rating": {"max": 10, "average": 7.0, "details":
//{"1": 17.0, "3": 608.0, "2": 89.0, "5": 168.0, "4": 468.0}, "stars": "35", "min": 0},
//"genres": ["\u7231\u60c5", "\u5947\u5e7b"],
//"title": "\u4eca\u591c\u5728\u6d6a\u6f2b\u5267\u573a",
//"casts": [
//  {"avatars": {"small": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p20694.webp"
//  , "large": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p20694.webp",
//  "medium": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p20694.webp"},
//  "name_en": "Haruka Ayase", "name": "\u7eeb\u6fd1\u9065", "alt": "https:\/\/movie.douban.com\/celebrity\/1035655\/",
//  "id": "1035655"}, {"avatars":
//{"small": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1406903709.34.webp",
//"large": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1406903709.34.webp",
//"medium": "https://img3.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1406903709.34.webp"},
//"name_en": "Kentaro Sakaguchi", "name": "\u5742\u53e3\u5065\u592a\u90ce",
//"alt": "https:\/\/movie.douban.com\/celebrity\/1340281\/", "id": "1340281"},
//{"avatars": {"small": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1519095769.99.webp",
//"large": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1519095769.99.webp",
//"medium": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p1519095769.99.webp"},
//"name_en": "Tsubasa Honda", "name": "\u672c\u7530\u7ffc", "alt": "https:\/\/movie.douban.com\/celebrity\/1317932\/",
//"id": "1317932"}], "durations": ["109\u5206\u949f"], "collect_count": 5062, "mainland_pubdate": "2019-02-14",
//"has_video": false, "original_title": "\u4eca\u591c\u3001\u30ed\u30de\u30f3\u30b9\u5287\u5834\u3067",
//"subtype": "movie", "directors": [{"avatars":
//{"small": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p48267.webp",
//"large": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p48267.webp",
//"medium": "https://img1.doubanio.com\/view\/celebrity\/s_ratio_celebrity\/public\/p48267.webp"},
//"name_en": "Hideki Takeuchi", "name": "\u6b66\u5185\u82f1\u6811",
//"alt": "https:\/\/movie.douban.com\/celebrity\/1316913\/", "id": "1316913"}],
//"pubdates": ["2018-02-10(\u65e5\u672c)", "2019-02-14(\u4e2d\u56fd\u5927\u9646)"],
//"year": "2018", "images": {"small": "https://img3.doubanio.com\/view\/photo\/s_ratio_poster\/public\/p2546938024.webp",
//"large": "https://img3.doubanio.com\/view\/photo\/s_ratio_poster\/public\/p2546938024.webp",
//"medium": "https://img3.doubanio.com\/view\/photo\/s_ratio_poster\/public\/p2546938024.webp"},
//"alt": "https:\/\/movie.douban.com\/subject\/27039378\/", "id": "27039378"}],
//"title": "\u5373\u5c06\u4e0a\u6620\u7684\u7535\u5f71"}
class ComingSoonBean {
  var rating;
  var genres;
  var title;
  var casts;
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

  ComingSoonBean.fromMap(Map<String, dynamic> map) {
    rating = map['rating'];
    genres = map['genres'];
    title = map['title'];
    casts = map['casts'];
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
}

class Images {
  var small;
  var large;
  var medium;

  Images(this.small, this.large, this.medium);
}
