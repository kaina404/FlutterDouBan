import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban_app/manager/router.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/celebrity_entity.dart';
import 'package:douban_app/widgets/title_bar.dart';
import 'package:douban_app/widgets/image/radius_img.dart';

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
  API _api = API();
  CelebrityEntity celebrityEntity;

  @override
  void initState() {
    super.initState();
    _api.searchCelebrity(widget.id, (celebrityEntity) {
      setState(() {
        this.celebrityEntity = celebrityEntity;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('人物'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: _getBody(),
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
                Text('简介'),
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
            child: Container(
              height: 200.0,
              child: ListView.builder(
                //TODO Shiyong影人作品API
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Photo bean = celebrityEntity.photos[index];
                  return RadiusImg.get(bean.cover, 50.0);
                },
                itemCount: celebrityEntity.photos.length,
              ),
            ),
          ),
        ],
      );
    }
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
