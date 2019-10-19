![](https://github.com/kaina404/FlutterDouBan/blob/master-new/logo.png)


[![GitHub stars](https://img.shields.io/github/stars/kaina404/FlutterDouBan.svg)](https://github.com/kaina404/FlutterDouBan/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kaina404/FlutterDouBan.svg)](https://github.com/kaina404/FlutterDouBan/network)
[![GitHub issues](https://img.shields.io/github/issues/kaina404/FlutterDouBan.svg)](https://github.com/kaina404/FlutterDouBan/issues) 

> Flutter SDK (Channel stable, v1.5.4-hotfix.2, on Mac OS X 10.13.6 17G2112, locale zh-Hans-CN， Dart SDK : 2.5.0)

> 如果产生其他依赖无法编译的问题，可以尝试将`pubspec.yaml`中的`dependencies`中的所有依赖的"^"去掉，重新编译尝试。

# [博客地址flutterall.com](http://www.flutterall.com)
真正的豆瓣客户端，90%还原豆瓣。首页、书影音、小组、市集及个人中心，一个不拉。项目持续更新中...
# [演示预览(右键，新标签页面打开)](https://img.xuvip.top/douyademo.mp4)

**如果您觉得还可以的话，给个Star白~**

# 使用Flutter开发一个豆瓣App
   
   * 此项目，90%还原某瓣APP，所有UI均按照某瓣来实现。
   * 项目中的数据均来自豆瓣api真实有效数据
   * 项目中用到了几乎所有的Flutter widget
   * 还有两个比较大的自定义魔改源码实现特效
   * 大年初一也在维护的项目
   
   > APP中所有数据均为真实数据。但是默认，对于"书影音单个电影tab"的数据，使用模拟数据。因为，频繁的打开关闭APP，会频繁调用
    这个接口。接口是有调用限制的，次数过于频繁，会被锁IP。如果想看真实数据，则可以进入
    "我的"，然后打开"书影音数据来自网络"开关后，重启APP即可。
    
# 下载地址

## [Release版本下载地址](https://www.pgyer.com/Gt1H)

![扫一扫下载体验](https://github.com/kaina404/FlutterDouBan/blob/master-new/douya-release.png)


   

   
#### Demo(刷不出gif图的，耐心等待一会，或者多刷几次。)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/0E95A04AE84EFE31104AC8E0A5808CB9.png)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/041919372752_04CCDD7BC1BDB6015935EE50DDF75C29F.png)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/041919374444_0B3C7C7E29941F75D0A7C944D4E352CB7.png)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/041919375761_05292CAB58428C7C77C544027FC899CC0.png)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/041919380838_07B17727ACF231C6D91914D71114A96CF.png)
![](https://github.com/kaina404/FlutterDouBan/blob/master-release/041919381924_01CE541B98F565C72B75567A319271CA1.png)

![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-12-55.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-13-11.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-17-38.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-17-48.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-18-03.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-18-12.gif)
    
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-18-23.gif)  
 
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-30-58.gif) 
  
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-31-13.gif) 
  
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-32-29.gif) 
  
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-32-41.gif) 
  
![demo1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/demogif/Mar-10-2019%2014-33-02.gif)   


   
# dev-open
   
   ### 大家可以向这个分支根据豆瓣UI做设计稿，提交代码

   * 这个分支供广大Flutter开发者来学习Flutter
   * **此分支囊括了Flutter 90%的组件的基本与组合使用**，是初学者真正实践的不错选择
   * 在此豆芽APP的首页实现与影片详情的UI特效，基于魔改Flutter源码。有兴趣可以看看
   * 大家想实战自己的Flutter能力，可以将某瓣APP作为设计稿，完成需求，并提交
   * 每位开发者提交的代码，我都会在文档中进行备注
   
   #### 注意！！！建议使用模拟数据(mock_request.dart)
   * 每个接口均有一定的调用限制
   *  *大家pull下的代码，进行测试调试时，对于特定接口，返回的特定数据。尽量不要每次求请求一次。可以请求到一次真实数据后，转成json保存
        到本地。然后，自己调试开发的时候，使用这个模拟数据即可。* [可参考mock_request.dart]
   
  

# 未来版本计划(欢迎Flutter爱好者前来认领)

 **欢迎Flutter爱好者共同完成**
   
 > 涉及到UI，可参考豆瓣。
   
### 萌新TASK
    
   * 完成任意一个未实现的按钮
   * 完成任意一个未实现的页面
   * 优化原有Widget
   * 爱好者想实现但是未能实现的需求
   * More ...
  
### 进阶TASK
  
  * 优化代码
  * 适当缓存数据
  * 解决卡顿(可参考：https://flutter-io.cn/docs/testing/ui-performance)
  * 优化路由（可参考咸鱼方案：https://www.yuque.com/xytech/flutter/vf1dpf）
  
### 老手TASK

 * [接入rxdart](https://github.com/ReactiveX/rxdart)
 * [使用Fish Redux 重构](https://www.yuque.com/xytech/flutter/ycc9ni)
 
 
   
# 对魔改源码或者喜欢翻源码的童鞋可以看看下面两个
   
 * 魔改Flutter AppBar源码实现豆瓣头部特效
 
    ![魔改Flutter AppBar源码实现豆瓣头部特效](https://github.com/kaina404/DouBanProject/blob/dev-0.1/%E4%BB%BF%E8%B1%86%E7%93%A3%E5%A4%B4%E9%83%A8.gif)

 * 魔改源码实现电影详情抽屉特效(GIF图如果加载不出来，多刷几次)
 
    ![抽屉特效1](https://github.com/kaina404/DouBanProject/blob/dev-0.1/part1.gif)
    
    ![抽屉特效2](https://github.com/kaina404/DouBanProject/blob/dev-0.1/part2.gif)
    
    ![抽屉特效3](https://github.com/kaina404/DouBanProject/blob/dev-0.1/part3.gif)
    
    
# 页面介绍
 
  * 首页 pages/home
        
    * homo_app_bar.dart 首页导航头
    * home_page.dart 首页
    * my_home_tab_bar.dart 首页tab
    
  * 书影音 pages/movie
  
    * book_audio_video_page.dart 书影音页面
    * detail_page.dart 影片、电视详情页面
    * person_detail_page.dart 演员页面介绍
    * ... 页面都有注释
    
  * 小组 pages/group
  
  * 市集 shop_page.dart 
    * 市集的数据使用两个webview
    
  * 我的 page/person
    
    

# 更新记录

 * dev-0.1
   * 魔改源码实现电影详情抽屉特效
   * 魔改Flutter AppBar源码实现豆瓣头部特效
   * 优化页面逻辑
   * 优化加载速度

 * master 
   * 基本网络请求框架、UI框架
   * 已经填入了"最为复杂的电影TAB页面"、影视详情页面、小组页面（UI与豆瓣一致，数据使用的是热映榜）
        * 页面上下滑动
        * 页面上下+左右滑动
        * 数据加载
        * TAB页面滑动
        * ....
   * 作为基本版本，一些逻辑不够完善，有一些bug。
  
# 默认条约

   此项目仅供大家交流沟通使用，不得用于任何商业以及利益活动。由此引起的责任，跟我无关。谢谢！

# **如果您觉得还可以的话，给个Star白~**

# Thanks

<img src="https://github.com/kaina404/FlutterDouBan/blob/master-new/48.jpg" width="426px">

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
 
