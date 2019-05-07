import 'package:flutter/material.dart';
import 'package:doubanapp/router.dart';
typedef TapCallback = void Function();

///《书影业》顶部四个TAB
class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _TextImgWidget(
          '找电影',
          'assets/images/find_movie.png',
          tabCallBack: () {
            print('点击找电影');
            Router.push(context, Router.searchPage, '找电影');
          },
        ),
        _TextImgWidget(
          '豆瓣榜单',
          'assets/images/douban_top.png',
          tabCallBack: () {
            print('点击豆瓣榜单');
            Router.push(context, Router.searchPage, '豆瓣榜单');
          },
        ),
        _TextImgWidget(
          '豆瓣猜',
          'assets/images/douban_guess.png',
          tabCallBack: () {
            Router.push(context, Router.searchPage, '豆瓣猜');
          },
        ),
        _TextImgWidget(
          '豆瓣片单',
          'assets/images/douban_film_list.png',
          tabCallBack: () {
            Router.push(context, Router.searchPage, '豆瓣片单');
          },
        )
      ],
    );
  }
}

class _TextImgWidget extends StatelessWidget {
  final String text;
  final String imgAsset;
  final TapCallback tabCallBack;

  _TextImgWidget(
    this.text,
    this.imgAsset, {
    Key key,
    this.tabCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tabCallBack != null) {
          tabCallBack();
        }
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            imgAsset,
            width: 45,
            height: 45,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(
                  255,
                  128,
                  128,
                  128,
                )),
          )
        ],
      ),
    );
  }
}
