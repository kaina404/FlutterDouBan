import 'package:flutter/material.dart';
import 'package:douban_app/widgets/search_text_field_widget.dart';
import 'package:douban_app/pages/home/home_app_bar.dart' as myapp;
import 'package:douban_app/http/http_request.dart';
import 'package:douban_app/http/mock_request.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/subject_entity.dart';
import 'package:douban_app/widgets/image/radius_img.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}

var _tabs = ['动态', '推荐'];

DefaultTabController getWidget() {
  return DefaultTabController(
    length: _tabs.length, // This is the number of tabs.
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // These are the slivers that show up in the "outer" scroll view.
        return <Widget>[
          SliverOverlapAbsorber(
            // This widget takes the overlapping behavior of the SliverAppBar,
            // and redirects it to the SliverOverlapInjector below. If it is
            // missing, then it is possible for the nested "inner" scroll view
            // below to end up under the SliverAppBar even when the inner
            // scroll view thinks it has not been scrolled.
            // This is not necessary if the "headerSliverBuilder" only builds
            // widgets that do not overlap the next sliver.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: myapp.SliverAppBar(
              pinned: true,
              expandedHeight: 120.0,
              primary: true,
              titleSpacing: 0.0,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: Colors.green,
                  child: SearchTextFieldWidget(
                    hintText: '影视作品中你难忘的离别',
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
              ),
              // The "forceElevated" property causes the SliverAppBar to show
              // a shadow. The "innerBoxIsScrolled" parameter is true when the
              // inner scroll view is scrolled beyond its "zero" point, i.e.
              // when it appears to be scrolled below the SliverAppBar.
              // Without this, there are cases where the shadow would appear
              // or not appear inappropriately, because the SliverAppBar is
              // not actually aware of the precise position of the inner
              // scroll views.
              bottomTextString: _tabs,
              bottom: TabBar(
                // These are the widgets to put in each tab in the tab bar.
                tabs: _tabs
                    .map((String name) => Container(
                          child: Text(
                            name,
                          ),
                          padding: const EdgeInsets.only(bottom: 5.0),
                        ))
                    .toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        // These are the contents of the tab views, below the tabs.
        children: _tabs.map((String name) {
          return SliverContainer(
            name: name,
          );
        }).toList(),
      ),
    ),
  );
}

class SliverContainer extends StatefulWidget {
  final String name;

  SliverContainer({Key key, @required this.name}) : super(key: key);

  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  @override
  void initState() {
    super.initState();
    print('init state${widget.name}');

    ///请求动态数据
    if (list == null || list.isEmpty) {
      if (_tabs[0] == widget.name) {
        requestAPI();
      } else {
        ///请求推荐数据
        requestAPI();
      }
    }
  }

  List<Subject> list;

  void requestAPI() async {
//    var _request = HttpRequest(API.BASE_URL);
//    int start = math.Random().nextInt(220);
//    final Map result = await _request.get(API.TOP_250 + '?start=$start&count=30');
//    var resultList = result['subjects'];

    var _request = MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultList = result['subjects'];
    list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(list);
  }

  getContentSliver(List<Subject> list) {
    if (list == null || list.length == 0) {
      return Text('暂无数据');
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is "inside"
        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
        // find the NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(widget.name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                // In this example, the inner scroll view has
                // fixed-height list items, hence the use of
                // SliverFixedExtentList. However, one could use any
                // sliver widget here, e.g. SliverList or SliverGrid.
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        ((BuildContext context, int index) {
                  Subject item = list[index];
                  return Container(
                    height: 140.0,
                    margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage:
                                  NetworkImage(item.casts[0].avatars.medium),
                              backgroundColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(item.title),
                            )
                          ],
                        ),
                        Expanded(
                            child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: RadiusImg.get(item.images.large, null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          bottomLeft: Radius.circular(5.0)),
                                    )),
                              ),
                              Expanded(
                                child: RadiusImg.get(
                                    item.casts[1].avatars.medium, null,
                                    radius: 0.0),
                              ),
                              Expanded(
                                child: RadiusImg.get(
                                    item.casts[2].avatars.medium, null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5.0),
                                            bottomRight:
                                                Radius.circular(5.0)))),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                }), childCount: list.length)),
              ),
            ],
          );
        },
      ),
    );
  }
}
