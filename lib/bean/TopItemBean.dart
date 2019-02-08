import 'package:douban_app/bean/WeeklyBean.dart';
import 'dart:math' as math;

class TopItemBean {
  var count;//共多少部
  var imgUrl;//图片url
  List<Item> items;//多少个电影
  TopItemBean(this.count, this.imgUrl, this.items);

  ///将周口碑榜数据转换成榜单item对应的数据类型
  static TopItemBean convertWeeklyBeans(List<WeeklyBean> weeklyBeans){
    var count = weeklyBeans.length;
    var imgUrl = weeklyBeans[0].subject.images.large;
    int itemCount = math.min(4, weeklyBeans.length);
    weeklyBeans = weeklyBeans.sublist(0, itemCount);
    List<Item> items = [];
    for(WeeklyBean bean in weeklyBeans){
      items.add(Item(bean.subject.title, bean.subject.rating.average, bean.delta > 0));
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
