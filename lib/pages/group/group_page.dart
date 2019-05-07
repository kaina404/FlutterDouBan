import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/search_text_field_widget.dart';
import 'package:doubanapp/router.dart';
import 'package:doubanapp/constant/constant.dart';
import 'package:doubanapp/http/API.dart';
import 'package:doubanapp/http/http_request.dart';
import 'package:doubanapp/bean/subject_entity.dart';
import 'package:doubanapp/widgets/loading_widget.dart';
import 'package:doubanapp/widgets/image/radius_img.dart';
///小组
class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String hintText = '搜索书影音 小组 日记 用户等';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          SearchTextFieldWidget(
            margin: EdgeInsets.all(Constant.MARGIN_RIGHT),
            hintText: hintText,
            onTab: () {
              Router.push(context, Router.searchPage, hintText);
            },
          ),
          Expanded(
            child: _GroupWidget(),
          )
        ],
      )),
    );
  }
}

class _GroupWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupWidgetState();
}

var _request = HttpRequest(API.BASE_URL);

class _GroupWidgetState extends State<_GroupWidget> {
  List<Subject> list;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future(() {
      return _request.get(API.IN_THEATERS);
    }).then((result) {
      var resultList = result['subjects'];
      setState(() {
        list =
            resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget.containerLoadingBody(_getBody(), loading: loading);
  }

  Widget _getBody() {
    if (list == null) {
      return Container(
        child: Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png'),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png');
        }

        Subject bean = list[index - 1];
        return Padding(
          padding: const EdgeInsets.only(
              right: Constant.MARGIN_RIGHT, left: 6.0, top: 13.0),
          child: _getItem(bean, index - 1),
        );
      },
      itemCount: list.length + 1,
    );
  }

  Widget _getItem(Subject bean, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: <Widget>[
          RadiusImg.get(bean.images.small, 50.0, radius: 3.0),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bean.title,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text(bean.pubdates != null ? bean.pubdates[0] : '', style: TextStyle(fontSize: 13.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text('${bean.collect_count}人', style: TextStyle(fontSize: 13.0),),
          ),
          GestureDetector(
            child: Image.asset(
              Constant.ASSETS_IMG +
                  (list[index].tag
                      ? 'ic_group_checked_anonymous.png'
                      : 'ic_group_check_anonymous.png'),
              width: 25.0,
              height: 25.0,
            ),
            onTap: () {
              setState(() {
                list[index].tag = !list[index].tag;
              });
            },
          )
        ],
      ),
      onTap: () {
        Router.push(context, Router.detailPage, bean.id);
      },
    );
  }
}
