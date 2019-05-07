
import 'package:doubanapp/bean/subject_entity.dart';
import 'dart:math' as math;

class TopItemBean {
  var count;//共多少部
  var imgUrl;//图片url
  List<Item> items;//多少个电影
  TopItemBean(this.count, this.imgUrl, this.items);

  ///将周口碑榜数据转换成榜单item对应的数据类型
  static TopItemBean convertWeeklyBeans(List<SubjectEntity> weeklyBeans){
    var count = '每周五更新 · 共${math.min(weeklyBeans.length, 10)}部';
    var imgUrl = weeklyBeans[0].subject.images.large;
    int itemCount = math.min(4, weeklyBeans.length);
    weeklyBeans = weeklyBeans.sublist(0, itemCount);
    List<Item> items = [];
    for(SubjectEntity bean in weeklyBeans){
      items.add(Item(bean.subject.title, bean.subject.rating.average, bean.delta > 0));
    }
    return TopItemBean(count, imgUrl, items);
  }

  ///将周热门数据转换成榜单item对应的数据类型
  static TopItemBean convertHotBeans(List<Subject> hotBeans) {
    var count = '每周五更新 · 共${math.min(10, hotBeans.length)}部';
    var imgUrl = hotBeans[0].images.large;
    int itemCount = math.min(4, hotBeans.length);
    hotBeans = hotBeans.sublist(0, itemCount);
    List<Item> items = [];
    for(Subject bean in hotBeans){
      items.add(Item(bean.title, bean.rating.average, true));
    }
    return TopItemBean(count, imgUrl, items);
  }
  ///将Top250数据转换成榜单item对应的数据类型
  static TopItemBean convertTopBeans(List<Subject> hotBeans) {
    var count = '豆瓣榜单 · 共250部';
    var imgUrl = hotBeans[0].images.large;
    int itemCount = math.min(4, hotBeans.length);
    hotBeans = hotBeans.sublist(0, itemCount);
    List<Item> items = [];
    for(Subject bean in hotBeans){
      items.add(Item(bean.title, bean.rating.average, true));
    }
    return TopItemBean(count, imgUrl, items);
  }

}

class Item {
  var title; //电影名称
  var average; //评分
  bool upOrDown; //热度上升还是下降

  Item(this.title, this.average, this.upOrDown);
}
