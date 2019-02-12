import 'package:flutter/material.dart';
import 'package:douban_app/widgets/SearchTextFieldWidget.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/search_result_entity.dart';
import 'package:douban_app/widgets/image/cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    if (imgW == null) {
      imgW = MediaQuery.of(context).size.width / 6;
      imgH = imgW / 0.75;
    }
//    if(_searchResultEntity == null){
//      return getSearchWidget();
//    }
    if (_searchResultEntity != null &&
        _searchResultEntity.subjects.isNotEmpty) {
      _searchResultEntity.subjects.sort((a, b) => (b.year.compareTo(a.year)));
    }
    return Scaffold(
      body: SafeArea(
          child: _searchResultEntity == null
              ? getSearchWidget()
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: getSearchWidget(),
                        ),
                        GestureDetector(
                          child: Text('取消'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          SearchResultSubject bean =
                              _searchResultEntity.subjects[index];
                          return _getItem(bean, index);
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
    return SearchTextFieldWidget(
      hintText: widget.searchHintContent,
      onSubmitted: (searchContent) {
        _api.searchMovie(searchContent, (searchResultEntity) {
          setState(() {
            _searchResultEntity = searchResultEntity;
          });
        });
      },
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
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(getType(bean.subtype)),
              Text(bean.title + '(${bean.year})'),
              Text(
                  '${bean.rating.average} 分 / ${bean.pubdates} / ${listConvertString(bean.genres)} / ${listConvertString2(bean.directors)}')
            ],
          ),
        )
      ],
    );
  }
}
