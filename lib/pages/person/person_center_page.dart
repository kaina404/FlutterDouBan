import 'package:flutter/material.dart';
import 'package:doubanapp/constant/constant.dart';
import 'package:doubanapp/widgets/image/heart_img_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doubanapp/constant/cache_key.dart';
import 'package:doubanapp/main.dart';
typedef VoidCallback = void Function();

///个人中心
class PersonCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build PersonCenterPage');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  flexibleSpace: HeartImgWidget(Image.asset(
                      Constant.ASSETS_IMG + 'bg_person_center_default.webp')),
                  expandedHeight: 200.0,
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 15.0, bottom: 20.0, right: 10.0),
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'ic_notify.png',
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '提醒',
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                      _rightArrow()
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100.0,
                    alignment: Alignment.center,
                    child: Text(
                      '暂无新提醒',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                _divider(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 20.0),
                    child: Text(
                      '我的书影音',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: _VideoBookMusicBookWidget(),
                  ),
                ),
                _divider(),
                _dataSelect(),
                _divider(),
                _personItem('ic_me_journal.png', '我的发布'),
                _personItem('ic_me_follows.png', '我的关注'),
                _personItem('ic_me_photo_album.png', '相册'),
                _personItem('ic_me_doulist.png', '豆列 / 收藏'),
                _divider(),
                _personItem('ic_me_wallet.png', '钱包'),
              ],
            ),
          )),
    );
  }

  _rightArrow() {
    return Icon(
      Icons.chevron_right,
      color: const Color.fromARGB(255, 204, 204, 204),
    );
  }

  SliverToBoxAdapter _divider() {
    return SliverToBoxAdapter(
      child: Container(
        height: 10.0,
        color: const Color.fromARGB(255, 247, 247, 247),
      ),
    );
  }

  SliverToBoxAdapter _personItem(String imgAsset, String title,
      {VoidCallback onTab}) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                Constant.ASSETS_IMG + imgAsset,
                width: 25.0,
                height: 25.0,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            _rightArrow()
          ],
        ),
        onTap: onTab,
      ),
    );
  }

  _dataSelect() {
    return UseNetDataWidget();
  }
}

///这个用来改变书影音数据来自网络还是本地模拟
class UseNetDataWidget extends StatefulWidget {
  @override
  _UseNetDataWidgetState createState() => _UseNetDataWidgetState();
}

class _UseNetDataWidgetState extends State<UseNetDataWidget> {
  bool mSelectNetData = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mSelectNetData = prefs.getBool(CacheKey.USE_NET_DATA) ?? true;
    });
  }

  _setData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(CacheKey.USE_NET_DATA, value);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Text('书影音数据是否来自网络', style: TextStyle(color: Colors.redAccent, fontSize: 17.0),),
            Expanded(
              child: Container(),
            ),
            CupertinoSwitch(
              value: mSelectNetData,
              onChanged: (bool value) {
                mSelectNetData = value;
                _setData(value);
                var tmp;
                if(value){
                  tmp = '书影音数据 使用网络数据，重启APP后生效';
                }else{
                  tmp = '书影音数据 使用本地数据，重启APP后生效';
                }
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(title: Text('提示'),content: Text(tmp),actions: <Widget>[
                    FlatButton(child: Text('稍后我自己重启'),onPressed: (){
                      Navigator.of(context).pop();
                    },),
                    FlatButton(child: Text('现在重启'),onPressed: (){
                      RestartWidget.restartApp(context);
                      Navigator.of(context).pop();
                    },)
                  ],);
                });
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

///影视、图书、音乐 TAB
class _VideoBookMusicBookWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoBookMusicBookWidgetState();
}

class _VideoBookMusicBookWidgetState extends State<_VideoBookMusicBookWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTxt.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: DefaultTabController(
          length: tabTxt.length,
          child: Column(
            children: <Widget>[
              Align(
                child: _TabBarWidget(),
                alignment: Alignment.centerLeft,
              ),
              _tabView()
            ],
          )),
    );
  }

  Widget _tabView() {
    return Expanded(
      child: TabBarView(
        children: [
          _tabBarItem('bg_videos_stack_default.png'),
          _tabBarItem('bg_books_stack_default.png'),
          _tabBarItem('bg_music_stack_default.png'),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget getTabViewItem(String img, String txt) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
            child: Image.asset(
              Constant.ASSETS_IMG + img,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(txt)
      ],
    );
  }

  _tabBarItem(String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getTabViewItem(img, '想看'),
        getTabViewItem(img, '在看'),
        getTabViewItem(img, '看过'),
      ],
    );
  }
}

///
///
class _TabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBarWidgetState();
}

TabController _tabController;

class _TabBarWidgetState extends State<_TabBarWidget> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  List<Widget> tabWidgets;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
    tabWidgets = tabTxt
        .map((item) =>
        Text(
          item,
          style: TextStyle(fontSize: 15),
        ))
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabWidgets,
      isScrollable: true,
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
    );
  }
}

final List<String> tabTxt = ['影视', '图书', '音乐'];
