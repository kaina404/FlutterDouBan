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
