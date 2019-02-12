豆瓣api使用

 BaseUrl = "https://douban.uieee.com/v2"
BaseUrl = "https://api.douban.com/v2"
获取电影信息
#电影条目搜索
https://api.douban.com/v2/movie/search
Example:
 * GET https://api.douban.com/v2/movie/search?q=张艺谋
 * GET https://api.douban.com/v2/movie/search?tag=喜剧
#正在热映
https://api.douban.com/v2/movie/in_theaters

Example:
GET https://api.douban.com/v2/movie/in_theaters
 * top250
https://api.douban.com/v2/movie/top250

Example:
GET https://api.douban.com/v2/movie/top250
#口碑榜
https://api.douban.com/v2/movie/weekly

Example:
GET https://api.douban.com/v2/movie/weekly
#北美票房榜
https://api.douban.com/v2/movie/us_box

Example:
GET https://api.douban.com/v2/movie/us_box
#新片榜
https://api.douban.com/v2/movie/new_movies?apikey=xxx

Example:
GET https://api.douban.com/v2/movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a
#获取电影信息
https://api.douban.com/v2/movie/:id

Example:
GET https://api.douban.com/v2/movie/4864908
#获取电影剧照
https://api.douban.com/v2/movie/subject/:id/photos?count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/subject/26825664/photos?count=100&apikey=0df993c66c0c636e29ecbb5344252a4a
#获取电影条目短评论
https://api.douban.com/v2/movie/subject/:id/comments?start=xxx&count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/subject/26825664/comments?start=1&count=100&apikey=0df993c66c0c636e29ecbb5344252a4a
#获取电影条目长评论
https://api.douban.com/v2/movie/subject/:id/reviews?start=xxx&count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/subject/26004132/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b
#获取影人条目信息
https://api.douban.com/v2/movie/celebrity/:id?start=xxx&count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/celebrity/1044707?apikey=0b2bdeda43b5688921839c8ecb20399b

#获取影人剧照
https://api.douban.com/v2/movie/celebrity/:id/photos?start=xxx&count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/celebrity/1044707/photos?apikey=0b2bdeda43b5688921839c8ecb20399b

GET https://api.douban.com/v2/movie/celebrity/1044707/photos?start=1&count=100&apikey=0b2bdeda43b5688921839c8ecb20399b

#获取影人作品
https://api.douban.com/v2/movie/celebrity/:id/works?start=xxx&count=xxx&apikey=xxxx

Example:
GET https://api.douban.com/v2/movie/celebrity/1044707/works?apikey=0b2bdeda43b5688921839c8ecb20399b

GET https://api.douban.com/v2/movie/celebrity/1044707/works?start=1&count=100&apikey=0b2bdeda43b5688921839c8ecb20399b


#搜索音乐
https://api.douban.com/v2/music/search

Example:
GET https://api.douban.com/v2/music/search?q="zsh"
#获取音乐信息
https://api.douban.com/v2/music/:id

Example:
GET https://api.douban.com/v2/music/2337701

#搜索图书
https://api.douban.com/v2/book/search

Example:
GET https://api.douban.com/v2/book/search?q="zsh"
#获取图书信息
https://api.douban.com/v2/book/:id

Example:
GET https://api.douban.com/v2/book/25902185





===============
===============
===============
===============




【 Android 】豆瓣电影 API 指南
96  tnnowu
2018.02.01 01:20* 字数 859 阅读 7839评论 8喜欢 16
豆瓣电影是人人皆知的一个版块，他的评分很具有代表性。我们就选用豆瓣电影 API 来进行电影类的数据获取。本篇文章应该是全网最新最全的 API 指南。

一、豆瓣电影 API 官方文档
调用第三方API接口首先看的不是其他人写的文章，而是去读官方接口文档，那里面是最新最全的。

从中我们可以读到API接口文档分成4大部分，14小部分：

电影条目

电影条目信息
电影条目剧照
电影条目长评
电影条目短评
影人条目

影人条目信息
影人剧照
影人作品
搜索

电影搜索
榜单

正在热映
即将上映
Top250
口碑榜
北美票房榜
新片榜
二、解析 API 接口获取服务器数据
网络请求使用RxJava2+Retrofit2，如果网络请求不太懂的可以看我的另一篇文章：网络请求框架 —— Retrofit

题外话：V2 版 API 权限分3类：公开、高级、商务，所以有些接口数据是请求不到的。

电影条目信息

/**
 * 电影条目信息
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * city：所在城市，例如北京、上海等
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：http://api.douban.com/v2/movie/subject/26004132?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：http://api.douban.com/v2/movie/subject/26004132?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&client=&udid=
 */
@GET("subject/{movieId}")
Observable<MovieSubjectInfoBean> getMovieSubjectInfo(@Path("movieId") String movieId,
                                                     @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/subject/MovieSubjectInfoActivity.java

Log日志：

onSubscribe:
onNext:
评分: 5.4
原名: The Maze Runner: The Death Cure
电影海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2508618114.jpg
年代: 2018
短评评分: 2
短评用户名: 舒农
短评内容: 删掉一个小时会更好。第三幕长到整部电影仿佛3个小时。
电影 ID: 26004132
上映日期: 2018-01-26
电影中文名: 移动迷宫3：死亡解药
语言: 英语
编剧头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1513398561.53.jpg
编剧英文名: T.S. Nowlin
编剧中文名: T·S·诺林
编剧 ID: 1342902
标签: 科幻
片长: 142分钟
影片类型: 动作, 科幻, 冒险
预告片图片: http://img3.doubanio.com/img/trailer/medium/2512246766.jpg?1517382304
预告片影片: http://vt1.doubanio.com/201802010046/aa610896c80023bcc278b67ef9daf775/view/movie/M/302260927.mp4
花絮图片: http://img7.doubanio.com/img/trailer/medium/2511634245.jpg?1516872258
花絮影片: http://vt1.doubanio.com/201802010046/3b1390d988dbf4e79be7ab35c770a592/view/movie/M/302260637.mp4
片段图片: http://img3.doubanio.com/img/trailer/medium/2511459538.jpg?1516696141
片段影片: http://vt1.doubanio.com/201802010046/afa09007e76a52890f30a610a1e1c3f5/view/movie/M/302260558.mp4
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53688.jpg
主演英文名: Dylan O'Brien
主演中文名: 迪伦·奥布莱恩
主演 ID: 1314963
制片国家/地区: 美国
大陆上映日期: 2018-01-26
电影剧照: http://img7.doubanio.com/view/photo/photo/public/p2511621790.jpg
简介: 《移动迷宫3》作为系列最终章，沿袭系列一贯以来的劲爆动作戏和快节奏跑酷风，主要讲述迪伦·奥布莱恩饰演的托马斯率领的好莱坞“跑男团”在经历了迷宫逃脱和末日丧尸的生死考验后，终于迎来最后的正邪较量。
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1417887954.94.jpg
导演英文名: Wes Ball
导演中文名: 韦斯·鲍尔
导演 ID: 1332723
影评评分: 2
影评标题: 导演的脑回路就是个迷宫，走进去就出不来了
影评用户名: 凌睿
影评内容: 整个系列都没有移动，为什么在片名里写个“移动”？你考虑过联通和电信的感受吗？ 《移动迷宫1》没有移动，好歹还有迷宫。 《移动迷宫2》没有移动，没有迷宫，好歹还很二。 《移动迷宫3：死亡解药》是移动、迷宫...
onComplete:
#电影条目剧照

/**
 * 电影条目剧照
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/subject/26004132/photos?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/subject/26004132/photos?apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=100&client=&udid=
 */
@GET("subject/{movieId}/photos")
Observable<MovieSubjectPhotosBean> getMovieSubjectPhotos(@Path("movieId") String movieId,
                                                         @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/subject/MovieSubjectPhotosActivity.java

Log日志：

onSubscribe:
onNext:
电影剧照: http://img7.doubanio.com/view/photo/photo/public/p2511051532.jpg
评分: 5.4
影片类型: 动作, 科幻, 冒险
影片标题: 移动迷宫3：死亡解药
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53688.jpg
主演英文名: Dylan O'Brien
主演中文名: 迪伦·奥布莱恩
主演 ID: 1314963
片长: 142分钟
大陆上映日期: 2018-01-26
原名: The Maze Runner: The Death Cure
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1417887954.94.jpg
导演英文名: Wes Ball
导演中文名: 韦斯·鲍尔
导演 ID: 1332723
onNext: 2018-01-26(美国), 2018-01-26(中国大陆)
年代: 2018
电影海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2508618114.jpg
电影 ID: 26004132
onComplete:
#电影条目长评

/**
 * 电影条目长评
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/subject/26004132/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/subject/26004132/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=20&client=&udid=
 */
@GET("subject/{movieId}/reviews")
Observable<MovieSubjectReviewsBean> getMovieSubjectReviews(@Path("movieId") String movieId,
                                                           @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/subject/MovieSubjectReviewsActivity.java

Log日志：

onSubscribe:
onNext:
评分: 2
用户名: 凌睿
评论标题: 导演的脑回路就是个迷宫，走进去就出不来了
评论简介: 整个系列都没有移动，为什么在片名里写个“移动”？你考虑过联通和电信的感受吗？ 《移动迷宫1》没有移动，好歹还有迷宫。 《移动迷宫2》没有移动，没有迷宫，好歹还很二。 《移动迷宫3：死亡解药》是移动、迷宫...
评论内容: 整个系列都没有移动，为什么在片名里写个“移动”？你考虑过联通和电信的感受吗？《移动迷宫1》没有移动，好歹还有迷宫。《移动迷宫2》没有移动，没有迷宫，好歹还很二。《移动迷宫3：死亡解药》是移动、迷宫、解药、二、小三通通都没有了，所以我只能选择死亡。。。
影片评分: 5.4
影片类型: 动作, 科幻, 冒险
影片标题: 移动迷宫3：死亡解药
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53688.jpg
主演英文名: Dylan O'Brien
主演中文名: 迪伦·奥布莱恩
主演 ID: 1314963
片长: 142分钟
大陆上映时间: 2018-01-26
原名: The Maze Runner: The Death Cure
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1417887954.94.jpg
导演英文名: Wes Ball
导演中文名: 韦斯·鲍尔
导演 ID: 1332723
上映日期: 2018-01-26(美国), 2018-01-26(中国大陆)
年代: 2018
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2508618114.jpg
影片 ID: 26004132
onComplete:
#电影条目短评

/**
 * 电影条目短评
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/subject/26004132/comments?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/subject/26004132/comments?apikey=0b2bdeda43b5688921839c8ecb20399b&count=20&client=&udid=
 */
@GET("subject/{movieId}/comments")
Observable<MovieSubjectCommentsBean> getMovieSubjectComments(@Path("movieId") String movieId,
                                                             @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/subject/MovieSubjectCommentsActivity.java

Log日志：

onSubscribe:
onNext:
评分: 2
用户名: 瓦力
评论内容: 1>2>3，场面比2升级了，迷宫？不存在的。槽点数量系列之最。请问：什么样的炸弹能瞬间炸塌百米高的城墙？什么样的人连人带车从百米高处坠落竟能毫发无伤？什么样的隔离玻璃一砸就碎？号称安保严密的据点被男主一行人轻易潜入且来去自如，结局混战毁一座城为救几十人死数万人，这是反乌托邦还是反人类？
影片评分: 5.4
影片类型: 动作, 科幻, 冒险
影片标题: 移动迷宫3：死亡解药
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53688.jpg
主演英文名: Dylan O'Brien
主演中文名: 迪伦·奥布莱恩
主演 ID: 1314963
片长: 142分钟
大陆上映日期: 2018-01-26
原名: The Maze Runner: The Death Cure
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1417887954.94.jpg
导演英文名: Wes Ball
导演中文名: 韦斯·鲍尔
导演 ID: 1332723
上映日期: 2018-01-26(美国), 2018-01-26(中国大陆)
年代: 2018
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2508618114.jpg
影片 ID: 26004132
onComplete:
#影人条目信息

/**
 * 影人条目信息
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 *
 * 全：https://api.douban.com/v2/movie/celebrity/1044707?apikey=0b2bdeda43b5688921839c8ecb20399b
 */
@GET("celebrity/{celebrityId}")
Observable<MovieCelebrityInfoBean> getMovieCelebrityInfo(@Path("celebrityId") String celebrityId,
                                                         @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/celebrity/MovieCelebrityInfoActivity.java

Log日志：

onSubscribe:
onNext:
中文名: 道恩·强森
英文名: Dwayne Johnson
性别: 男
职业: 演员, 制片, 配音
影人头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p196.jpg
简介: “岩石”（The Rock）本名叫德威恩·约翰逊（Dwayne Johnson），曾是世界摔角联联合会的冠军和明星人物。在体育界成名后，他的触角逐渐伸向影视圈，先是参加了一些电视节目的录制，然后又在连续剧中露过几面。凭着健硕的身材、英俊的相貌和广泛的知名度，“岩石”很快就在这个圈子里得到了不错的口碑。岩石， 1972年5月2日 生于美国加州的海沃德，是他们家第3代摔角手，父亲是著名摔角健将洛奇·约翰逊，爷爷彼得·麦维亚也是摔角界的传奇人物。耳闻目染之下，他从小即掌握了一些极佳的摔角技巧。父亲从小对他要求严格，希望长大培养出新一代的摔交手。岩石从8岁时就开始练拳，14岁走进健身房，成年后练就了一副好的体格，他的成功应该归功于他老爸的鼓励和自己的毅力、信心。
影人剧照: http://img3.doubanio.com/view/photo/photo/public/p2207562906.jpg
出生日期: 1972-05-02
更多中文名: 巨石强森, 德威恩·道格拉斯·约翰逊, 唐尼·约翰逊, 岩石, 巨石, 狄维庄逊(港)
出生地: 美国,加利福尼亚,海沃德
星座: 金牛座
影人 ID: 1044707
作品担任角色: 演员
作品评分: 9.2
作品类型: 喜剧, 音乐
作品名: 周六夜现场 第一季
作品主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1408438010.98.jpg
作品主演英文名: Don Pardo
作品主演中文名: 唐·帕尔多
作品主演 ID: 1126676
作品片长: 90分钟
作品大陆上映日期:
作品原名: Saturday Night Live
作品类别: tv
作品导演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p48858.jpg
作品导演英文名: Lorne Michaels
作品导演中文名: 洛恩·迈克尔斯
作品导演 ID: 1041290
作品上映日期: 1975-10-11(美国)
作品年代: 1975
作品海报图: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2503284915.jpg
作品 ID: 1887452
onComplete:
#影人剧照

/**
 * 影人剧照
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 *
 * 全：https://api.douban.com/v2/movie/celebrity/1044707/photos?apikey=0b2bdeda43b5688921839c8ecb20399b
 */
@GET("celebrity/{celebrityId}/photos")
Observable<MovieCelebrityPhotosBean> getMovieCelebrityPhotos(@Path("celebrityId") String celebrityId,
                                                             @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/celebrity/MovieCelebrityPhotoActivity.java

Log日志：

onSubscribe:
onNext:
影人剧照: http://img3.doubanio.com/view/photo/photo/public/p2207562906.jpg
影人头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p196.jpg
影人英文名: Dwayne Johnson
影人中文名: 道恩·强森
影人 ID: 1044707
onComplete:
#影人作品

/**
 * 影人作品
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 *
 * 全：https://api.douban.com/v2/movie/celebrity/1044707/works?apikey=0b2bdeda43b5688921839c8ecb20399b
 */
@GET("celebrity/{celebrityId}/works")
Observable<MovieCelebrityWorksBean> getMovieCelebrityWorks(@Path("celebrityId") String celebrityId,
                                                           @Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/celebrity/MovieCelebrityWorkActivity.java

Log日志：

onSubscribe:
onNext:
作品担任角色: 演员
作品评分: 0
作品类型: 动作, 冒险
作品名: 地心历险记4
作品主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p196.jpg
作品主演英文名: Dwayne Johnson
作品主演中文名: 道恩·强森
作品主演 ID: 1044707
作品片长:
作品大陆上映日期:
作品原名: Journey to the Center of the Earth 4
作品类别: movie
作品上映日期:
作品年代: 2020
作品海报图: http://img3.doubanio.com/f/movie/5081e011b4b06f1a8c3735122b38e781bd852ab6/pics/movie/movie_default_medium.png
作品 ID: 25963336
onComplete:
#电影搜索

/**
 * 电影搜索
 *
 * q:字符串
 * tag:标签
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 *
 * 全：https://api.douban.com/v2/movie/search?q=周杰伦&apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10
 * 全：https://api.douban.com/v2/movie/search?tag=喜剧&apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10
 */
// 根据字段搜索
@GET("search")
Observable<MovieSearchByQueryBean> getMovieSearchByQuery(@Query("q") String q,
                                                         @Query("apikey") String apikey,
                                                         @Query("start") int start,
                                                         @Query("count") int count);

// 根据标签搜索
@GET("search")
Observable<MovieSearchByTagBean> getMovieSearchByTag(@Query("tag") String tag,
                                                     @Query("apikey") String apikey,
                                                     @Query("start") int start,
                                                     @Query("count") int count);
网络请求示例：https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/search/MovieSearchQActivity.java

https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/search/MovieSearchTagActivity.java

Log日志：

onSubscribe:
onNext:
评分: 7.6
影片类型: 剧情, 奇幻, 音乐
影片标题: 不能说的秘密
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p18606.jpg
主演英文名: Jay Chou
主演中文名: 周杰伦
主演 ID: 1048000
片长: 101 分钟
大陆上映日期: 2007-07-31
原名: 不能說的·祕密
类型: movie
导演英文名: Jay Chou
导演中文名: 周杰伦
上映日期: 2007-07-27(台湾), 2007-07-31(中国大陆)
年代: 2007
影片海报: http://img3.doubanio.com/view/photo/s_ratio_poster/public/p917037900.jpg
影片 ID: 2124724
onComplete:
onSubscribe:
onNext:
评分: 9.2
影片类型: 剧情, 喜剧, 爱情
影片标题: 三傻大闹宝莱坞
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p13628.jpg
主演英文名: Aamir Khan
主演中文名: 阿米尔·汗
主演 ID: 1031931
片长: 171分钟(印度)
大陆上映日期: 2011-12-08
原名: 3 Idiots
类型: movie
导演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p16549.jpg
导演英文名: Rajkumar Hirani
导演中文名: 拉吉库马尔·希拉尼
导演 ID: 1286677
上映日期: 2009-12-25(印度), 2011-12-08(中国大陆)
年代: 2009
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p579729551.jpg
影片 ID: 3793023
onComplete:
#正在热映

/**
 * 正在热映
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * city：所在城市，例如北京、上海等
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=
 */
@GET("in_theaters")
Observable<MovieInTheatersBean> getMovieInTheaters(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListInTheatersActivity.java

Log日志：

onSubscribe:
onNext:
评分: 7.4
影片类型: 剧情, 传记, 歌舞
影片标题: 马戏之王
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p22036.jpg
主演英文名: Hugh Jackman
主演中文名: 休·杰克曼
主演 ID: 1010508
片长: 105分钟, 106分钟(中国大陆)
大陆上映日期: 2018-02-01
原名: The Greatest Showman
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1498127697.1.jpg
导演英文名: Michael Gracey
导演中文名: 迈克尔·格雷西
导演 ID: 1344735
上映日期: 2017-12-20(美国), 2018-02-01(中国大陆)
年代: 2017
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2511346392.jpg
影片 ID: 3914513
onComplete:
#即将上映

/**
 * 即将上映
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * city：所在城市，例如北京、上海等
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=
 */
@GET("coming_soon")
Observable<MovieComingSoonBean> getMovieComingSoon(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListComingSoonActivity.java

Log日志：

onSubscribe:
onNext:
评分: 7.1
影片类型: 喜剧, 惊悚, 恐怖
影片标题: 忌日快乐
主演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510538799.61.jpg
主演英文名: Jessica Rothe
主演中文名: 杰西卡·罗德
主演 ID: 1325899
片长: 96分钟
大陆上映日期: 2018-02-02
原名: Happy Death Day
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p18083.jpg
导演英文名: Christopher Landon
导演中文名: 克里斯托弗·兰登
导演 ID: 1032310
上映日期: 2017-10-13(美国), 2018-02-02(中国大陆)
年代: 2017
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2510057340.jpg
影片 ID: 27027913
onComplete:
#Top250

/**
 * Top250
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * city：所在城市，例如北京、上海等
 * start：分页使用，表示第几页
 * count：分页使用，表示数量
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/top250?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/top250?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=
 */
@GET("top250")
Observable<MovieTop250Bean> getMovieTop250(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListTop250Activity.java

Log日志：

onSubscribe:
onNext:
评分: 9.6
影片类型: 犯罪, 剧情
影片标题: 肖申克的救赎
主演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p17525.jpg
主演英文名: Tim Robbins
主演中文名: 蒂姆·罗宾斯
主演 ID: 1054521
片长: 142 分钟
大陆上映日期:
原名: The Shawshank Redemption
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p230.jpg
导演英文名: Frank Darabont
导演中文名: 弗兰克·德拉邦特
导演 ID: 1047973
上映日期: 1994-09-10(多伦多电影节), 1994-10-14(美国)
年代: 1994
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p480747492.jpg
影片 ID: 1292052
onComplete:
#口碑榜

/**
 * 口碑榜
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * city：所在城市，例如北京、上海等
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&client=&udid=
 */
@GET("weekly")
Observable<MovieWeeklyBean> getMovieWeekly(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListWeeklyActivity.java

Log日志：

onSubscribe:
onNext:
评分: 8.6
影片类型: 剧情, 儿童, 家庭
影片标题: 奇迹男孩
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1456737567.18.jpg
主演英文名: Jacob Tremblay
主演中文名: 雅各布·特伦布莱
主演 ID: 1332866
片长: 113分钟, 114分钟(中国大陆)
大陆上映日期: 2018-01-19
原名: Wonder
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p57551.jpg
导演英文名: Stephen Chbosky
导演中文名: 斯蒂芬·卓博斯基
导演 ID: 1070754
上映日期: 2017-11-17(美国), 2018-01-19(中国大陆)
年代: 2017
影片海报: http://img3.doubanio.com/view/photo/s_ratio_poster/public/p2507709428.jpg
影片 ID: 26787574
onComplete:
#北美票房榜

/**
 * 北美票房榜
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/us_box?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/us_box?apikey=0b2bdeda43b5688921839c8ecb20399b&client=&udid=
 */
@GET("us_box")
Observable<MovieUsBoxBean> getMovieUsBox(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListUsBoxActivity.java

Log日志：

onSubscribe:
onNext:
日期: 1月26日 - 1月28日
排行: 1
评分: 5.4
影片类型: 动作, 科幻, 冒险
影片标题: 移动迷宫3：死亡解药
主演头像: http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p53688.jpg
主演英文名: Dylan O'Brien
主演中文名: 迪伦·奥布莱恩
主演 ID: 1314963
片长: 142分钟
大陆上映日期: 2018-01-26
原名: The Maze Runner: The Death Cure
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1417887954.94.jpg
导演英文名: Wes Ball
导演中文名: 韦斯·鲍尔
导演 ID: 1332723
上映日期: 2018-01-26(美国), 2018-01-26(中国大陆)
年代: 2018
影片海报: http://img7.doubanio.com/view/photo/s_ratio_poster/public/p2508618114.jpg
影片 ID: 26004132
onComplete:
#新片榜

/**
 * 新片榜
 *
 * apikey：固定值 0b2bdeda43b5688921839c8ecb20399b
 * client：客户端信息。可为空
 * udid：用户 id。可为空
 *
 * 简：https://api.douban.com/v2/movie/new_movies?apikey=0b2bdeda43b5688921839c8ecb20399b
 * 全：https://api.douban.com/v2/movie/new_movies?apikey=0b2bdeda43b5688921839c8ecb20399b&client=&udid=
 */
@GET("new_movies")
Observable<MovieNewMoviesBean> getMovieNewMovies(@Query("apikey") String apikey);
网络请求示例：
https://github.com/cnwutianhao/DoubanMovie/blob/master/app/src/main/java/com/haocent/android/doubanmovie/ui/list/MovieListNewActivity.java

Log日志：

onSubscribe:
onNext:
评分: 8.7
影片类型: 剧情, 犯罪
影片标题: 三块广告牌
主演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1436865941.42.jpg
主演英文名: Frances McDormand
主演中文名: 弗兰西斯·麦克多蒙德
主演 ID: 1010548
片长: 115分钟
大陆上映日期: 2018-03-02
原名: Three Billboards Outside Ebbing, Missouri
导演头像: http://img7.doubanio.com/view/celebrity/s_ratio_celebrity/public/p3143.jpg
导演英文名: Martin McDonagh
导演中文名: 马丁·麦克唐纳
导演 ID: 1000304
上映日期: 2017-09-04(威尼斯电影节), 2017-11-10(美国), 2018-03-02(中国大陆)
年代: 2017
影片海报: http://img3.doubanio.com/view/photo/s_ratio_poster/public/p2510081688.jpg
影片 ID: 26611804
onComplete:
示例项目代码已上传至GitHub，如果本文对你有帮助请点赞，谢谢。
https://github.com/cnwutianhao/DoubanMovie

