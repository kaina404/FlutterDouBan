import 'package:douban_app/bean/celebrity_work_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban_app/manager/router.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/celebrity_entity.dart';
import 'package:douban_app/widgets/title_bar.dart';
import 'package:douban_app/widgets/rating_bar.dart';
import 'package:douban_app/widgets/SubjectMarkImageWidget.dart';
import 'package:douban_app/widgets/image/radius_img.dart';
import 'package:douban_app/repository/person_detail_repository.dart';
import 'package:douban_app/widgets/ItemCountTitle.dart';
import 'package:douban_app/widgets/loading_widget.dart';

class PersonDetailPage extends StatefulWidget {
  final String id;
  final String personImgUrl;

  const PersonDetailPage(this.personImgUrl, this.id, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailPageState();
  }
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  CelebrityEntity celebrityEntity;

  CelebrityWorkEntity celebrityWorkEntity;
  double itemW;
  double itemH;
  double photoH;
  double titleSize = 15.0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    itemW = MediaQuery.of(context).size.width / 4;
    itemH = itemW / 0.5;
    photoH = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('人物'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: LoadingWidget.containerLoadingBody(_getBody(),
              loading: loading, backgroundColor: Colors.transparent),
        ),
      ),
    );
  }

  _getBody() {
    if (celebrityEntity == null) {
      return _PersonPhoto(
        photoUrl: widget.personImgUrl,
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _PersonPhoto(
                      photoUrl: widget.personImgUrl,
                    ),
                    Column(
                      children: <Widget>[
                        Text(celebrityEntity.name),
                        Text(celebrityEntity.name_en),
                      ],
                    )
                  ],
                ),
                Text(
                  '简介',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: titleSize),
                ),
                Text(
                  celebrityEntity.summary,
                  softWrap: true,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ItemCountTitle(
              '影视',
              count: celebrityWorkEntity.works.length,
              fontSize: titleSize,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: itemH,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  CelebrityWorkWorksSubject bean =
                      celebrityWorkEntity.works[index].subject;
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: _getItem(bean),
                  );
                },
                itemCount: celebrityWorkEntity.works.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ItemCountTitle(
              '相册',
              count: celebrityEntity.photos.length,
              fontSize: titleSize,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: photoH,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.0, right: 3.0),
                    child: Image.network(
                      celebrityEntity.photos[index].image,
                      height: photoH,
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: celebrityEntity.photos.length,
              ),
            ),
          )
        ],
      );
    }
  }

  void requestAPI() async {
    Future(() => (PersonDetailRepository().requestAPI(widget.id)))
        .then((personDetailRepository) {
      setState(() {
        loading = false;
        celebrityEntity = personDetailRepository.celebrityEntity;
        celebrityWorkEntity = personDetailRepository.celebrityWorkEntity;
      });
    });
  }

  ///影院热映item
  Widget _getItem(CelebrityWorkWorksSubject bean) {
    if (bean == null || bean.images.large == null) {
      return Container();
    }
    return GestureDetector(
      child: Container(
        width: itemW,
        height: itemH,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SubjectMarkImageWidget(
              bean.images.large,
              width: itemW,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  bean.title,

                  ///文本只显示一行
                  softWrap: false,

                  ///多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              bean.rating.average,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: () {
        Router.push(context, Router.detailPage, bean.id);
      },
    );
  }
}

class _PersonPhoto extends StatelessWidget {
  const _PersonPhoto({Key key, this.photoUrl}) : super(key: key);
  final String photoUrl;

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 5;
    return SizedBox(
      width: w,
      child: Hero(
        tag: photoUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: RadiusImg.get(photoUrl, w, imgH: w / 0.8, elevation: 3.0),
          ),
        ),
      ),
    );
  }
}
//Image.network(
//photoUrl,
//fit: BoxFit.contain,
//)
