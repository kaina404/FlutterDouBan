import 'package:flutter/material.dart';
import 'package:doubanapp/widgets/search_text_field_widget.dart';
import 'package:doubanapp/http/API.dart';
import 'package:doubanapp/bean/search_result_entity.dart';
//import 'package:doubanapp/widgets/image/cached_network_image.dart';
import 'package:doubanapp/router.dart';
import 'package:flutter/cupertino.dart';

///搜索
class SearchPage extends StatefulWidget {
  final String searchHintContent;

  ///搜索框中的默认显示内容
  SearchPage({Key key, this.searchHintContent = '用一部电影来形容你的2018'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final API _api = API();
  SearchResultEntity _searchResultEntity;
  var imgW;
  var imgH;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    if (imgW == null) {
      imgW = MediaQuery.of(context).size.width / 7;
      imgH = imgW / 0.75;
    }
    if (_searchResultEntity != null &&
        _searchResultEntity.subjects.isNotEmpty) {
      _searchResultEntity.subjects.sort((a, b) => (b.year.compareTo(a.year)));
    }
    return Scaffold(
      body: SafeArea(
          child: showLoading
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : _searchResultEntity == null
                  ? getSearchWidget()
                  : Column(
                      children: <Widget>[
                        getSearchWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              SearchResultSubject bean =
                                  _searchResultEntity.subjects[index];
                              return Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: _getItem(bean, index),
                                  onTap: () {
                                    Router.push(
                                        context, Router.detailPage, bean.id);
                                  },
                                ),
                              );
                            },
                            itemCount: _searchResultEntity.subjects.length,
                          ),
                        )
                      ],
                    )),
    );
  }

  String getType(String subtype) {
    switch (subtype) {
      case 'movie':
        return '电影';
    }
    return '';
  }

  String listConvertString2(List<SearchResultSubjectsDirector> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (SearchResultSubjectsDirector item in genres) {
        tmp = tmp + item.name;
      }
      return tmp;
    }
  }

  String listConvertString(List<String> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (String item in genres) {
        tmp = tmp + item;
      }
      return tmp;
    }
  }

  Widget getSearchWidget() {
    return Padding(
      padding:
          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SearchTextFieldWidget(
              hintText: widget.searchHintContent,
              onSubmitted: (searchContent) {
                showLoading = true;
                _api.searchMovie(searchContent, (searchResultEntity) {
                  setState(() {
                    showLoading = false;
                    _searchResultEntity = searchResultEntity;
                  });
                });
              },
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                '取消',
                style: getStyle(Colors.green, 17.0),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget _getItem(SearchResultSubject bean, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Image.network(
            bean.images.medium,
            fit: BoxFit.cover,
            width: imgW,
            height: imgH,
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getType(bean.subtype),
                style: getStyle(Colors.grey, 12.0),
              ),
              Text(bean.title + '(${bean.year})',
                  style: getStyle(Colors.black, 15.0, bold: true)),
              Text(
                  '${bean.rating.average} 分 / ${listConvertString(bean.pubdates)} / ${listConvertString(bean.genres)} / ${listConvertString2(bean.directors)}',
                  style: getStyle(Colors.grey, 13.0))
            ],
          ),
        )
      ],
    );
  }

  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}
