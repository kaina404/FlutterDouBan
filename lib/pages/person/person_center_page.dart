import 'package:flutter/material.dart';
import 'package:douban_app/constant/Constant.dart';

typedef VoidCallback = void Function();

///个人中心
class PersonCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(padding: EdgeInsets.only(top: 10.0),child: CustomScrollView(
        shrinkWrap: false,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Image.network(
              'https://upload-images.jianshu.io/upload_images/3884536-33d4ced049938cb9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp',
              fit: BoxFit.cover,
              color: Colors.orangeAccent,
              colorBlendMode: BlendMode.saturation,
            ),
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
              padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
              child: Text(
                '我的书影音',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: _VideoBookMusicBookWidget(),
            ),
          ),
          _divider(),
          _personItem('ic_me_journal.png', '我的发布'),
          _personItem('ic_me_follows.png', '我的关注'),
          _personItem('ic_me_photo_album.png', '相册'),
          _personItem('ic_me_doulist.png', '豆列 / 收藏'),
          _divider(),
          _personItem('ic_me_wallet.png', '钱包'),
        ],
      ),)),
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
        .map((item) => Text(
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
