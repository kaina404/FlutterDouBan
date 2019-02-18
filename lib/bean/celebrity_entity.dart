import 'dart:convert' show json;

class CelebrityEntity {

	String alt;
	String birthday;
	String born_place;
	String constellation;
	String gender;
	String id;
	String mobile_url;
	String name;
	String name_en;
	String summary;
	String website;
	List<String> aka;
	List<String> aka_en;
	List<Photo> photos;
	List<String> professions;
	List<Work> works;
	Avatars avatars;

	CelebrityEntity.fromParams({this.alt, this.birthday, this.born_place, this.constellation, this.gender, this.id, this.mobile_url, this.name, this.name_en, this.summary, this.website, this.aka, this.aka_en, this.photos, this.professions, this.works, this.avatars});

	factory CelebrityEntity(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CelebrityEntity.fromJson(json.decode(jsonStr)) : new CelebrityEntity.fromJson(jsonStr);

	CelebrityEntity.fromJson(jsonRes) {
		alt = jsonRes['alt'];
		birthday = jsonRes['birthday'];
		born_place = jsonRes['born_place'];
		constellation = jsonRes['constellation'];
		gender = jsonRes['gender'];
		id = jsonRes['id'];
		mobile_url = jsonRes['mobile_url'];
		name = jsonRes['name'];
		name_en = jsonRes['name_en'];
		summary = jsonRes['summary'];
		website = jsonRes['website'];
		aka = jsonRes['aka'] == null ? null : [];

		for (var akaItem in aka == null ? [] : jsonRes['aka']){
			aka.add(akaItem);
		}

		aka_en = jsonRes['aka_en'] == null ? null : [];

		for (var aka_enItem in aka_en == null ? [] : jsonRes['aka_en']){
			aka_en.add(aka_enItem);
		}

		photos = jsonRes['photos'] == null ? null : [];

		for (var photosItem in photos == null ? [] : jsonRes['photos']){
			photos.add(photosItem == null ? null : new Photo.fromJson(photosItem));
		}

		professions = jsonRes['professions'] == null ? null : [];

		for (var professionsItem in professions == null ? [] : jsonRes['professions']){
			professions.add(professionsItem);
		}

		works = jsonRes['works'] == null ? null : [];

		for (var worksItem in works == null ? [] : jsonRes['works']){
			works.add(worksItem == null ? null : new Work.fromJson(worksItem));
		}

		avatars = jsonRes['avatars'] == null ? null : new Avatars.fromJson(jsonRes['avatars']);
	}

	@override
	String toString() {
		return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"birthday": ${birthday != null?'${json.encode(birthday)}':'null'},"born_place": ${born_place != null?'${json.encode(born_place)}':'null'},"constellation": ${constellation != null?'${json.encode(constellation)}':'null'},"gender": ${gender != null?'${json.encode(gender)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mobile_url": ${mobile_url != null?'${json.encode(mobile_url)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"website": ${website != null?'${json.encode(website)}':'null'},"aka": $aka,"aka_en": $aka_en,"photos": $photos,"professions": $professions,"works": $works,"avatars": $avatars}';
	}
}

class Avatars {

	String large;
	String medium;
	String small;

	Avatars.fromParams({this.large, this.medium, this.small});

	Avatars.fromJson(jsonRes) {
		large = jsonRes['large'];
		medium = jsonRes['medium'];
		small = jsonRes['small'];
	}

	@override
	String toString() {
		return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
	}
}

class Work {

	List<String> roles;
	WorkSubject subject;

	Work.fromParams({this.roles, this.subject});

	Work.fromJson(jsonRes) {
		roles = jsonRes['roles'] == null ? null : [];

		for (var rolesItem in roles == null ? [] : jsonRes['roles']){
			roles.add(rolesItem);
		}

		subject = jsonRes['subject'] == null ? null : new WorkSubject.fromJson(jsonRes['subject']);
	}

	@override
	String toString() {
		return '{"roles": $roles,"subject": $subject}';
	}
}

class WorkSubject {

	int collect_count;
	bool has_video;
	String alt;
	String id;
	String mainland_pubdate;
	String original_title;
	String subtype;
	String title;
	String year;
	List<CastDict> casts;
	List<dynamic> directors;
	List<String> durations;
	List<dynamic> genres;
	List<String> pubdates;
	_Image images;
	Rating rating;

	WorkSubject.fromParams({this.collect_count, this.has_video, this.alt, this.id, this.mainland_pubdate, this.original_title, this.subtype, this.title, this.year, this.casts, this.directors, this.durations, this.genres, this.pubdates, this.images, this.rating});

	WorkSubject.fromJson(jsonRes) {
		collect_count = jsonRes['collect_count'];
		has_video = jsonRes['has_video'];
		alt = jsonRes['alt'];
		id = jsonRes['id'];
		mainland_pubdate = jsonRes['mainland_pubdate'];
		original_title = jsonRes['original_title'];
		subtype = jsonRes['subtype'];
		title = jsonRes['title'];
		year = jsonRes['year'];
		casts = jsonRes['casts'] == null ? null : [];

		for (var castsItem in casts == null ? [] : jsonRes['casts']){
			casts.add(castsItem == null ? null : new CastDict.fromJson(castsItem));
		}

		directors = jsonRes['directors'] == null ? null : [];

		for (var directorsItem in directors == null ? [] : jsonRes['directors']){
			directors.add(directorsItem);
		}

		durations = jsonRes['durations'] == null ? null : [];

		for (var durationsItem in durations == null ? [] : jsonRes['durations']){
			durations.add(durationsItem);
		}

		genres = jsonRes['genres'] == null ? null : [];

		for (var genresItem in genres == null ? [] : jsonRes['genres']){
			genres.add(genresItem);
		}

		pubdates = jsonRes['pubdates'] == null ? null : [];

		for (var pubdatesItem in pubdates == null ? [] : jsonRes['pubdates']){
			pubdates.add(pubdatesItem);
		}

		images = jsonRes['images'] == null ? null : new _Image.fromJson(jsonRes['images']);
		rating = jsonRes['rating'] == null ? null : new Rating.fromJson(jsonRes['rating']);
	}

	@override
	String toString() {
		return '{"collect_count": $collect_count,"has_video": $has_video,"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mainland_pubdate": ${mainland_pubdate != null?'${json.encode(mainland_pubdate)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"subtype": ${subtype != null?'${json.encode(subtype)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"year": ${year != null?'${json.encode(year)}':'null'},"casts": $casts,"directors": $directors,"durations": $durations,"genres": $genres,"pubdates": $pubdates,"images": $images,"rating": $rating}';
	}
}

class Rating {

	int max;
	int min;
	var average;
	String stars;
	Detail details;

	Rating.fromParams({this.max, this.min, this.average, this.stars, this.details});

	Rating.fromJson(jsonRes) {
		max = jsonRes['max'];
		min = jsonRes['min'];
		average = jsonRes['average'];
		stars = jsonRes['stars'];
		details = jsonRes['details'] == null ? null : new Detail.fromJson(jsonRes['details']);
	}

	@override
	String toString() {
		return '{"max": $max,"min": $min,"average": $average,"stars": ${stars != null?'${json.encode(stars)}':'null'},"details": $details}';
	}
}

class Detail {

	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	Detail.fromParams({this.d1, this.d2, this.d3, this.d4, this.d5});

	Detail.fromJson(jsonRes) {
		d1 = jsonRes['1'];
		d2 = jsonRes['2'];
		d3 = jsonRes['3'];
		d4 = jsonRes['4'];
		d5 = jsonRes['5'];
	}

	@override
	String toString() {
		return '{"1": $d1,"2": $d2,"3": $d3,"4": $d4,"5": $d5}';
	}
}

class _Image {

	String large;
	String medium;
	String small;

	_Image.fromParams({this.large, this.medium, this.small});

	_Image.fromJson(jsonRes) {
		large = jsonRes['large'];
		medium = jsonRes['medium'];
		small = jsonRes['small'];
	}

	@override
	String toString() {
		return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
	}
}

class CastDict {

	String alt;
	Avatars avatars;
	String id;
	String name;
	String name_en;

	CastDict.fromParams({this.alt, this.avatars, this.id, this.name, this.name_en});

	CastDict.fromJson(jsonRes) {
		alt = jsonRes['alt'];
		avatars = jsonRes['avatars'] == null ? null : new Avatars.fromJson(jsonRes['avatars']);
		id = jsonRes['id'];
		name = jsonRes['name'];
		name_en = jsonRes['name_en'];
	}

	@override
	String toString() {
		return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"avatars": $avatars,"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'}}';
	}
}

class Photo {

	String alt;
	String cover;
	String icon;
	String id;
	String image;
	String thumb;

	Photo.fromParams({this.alt, this.cover, this.icon, this.id, this.image, this.thumb});

	Photo.fromJson(jsonRes) {
		alt = jsonRes['alt'];
		cover = jsonRes['cover'];
		icon = jsonRes['icon'];
		id = jsonRes['id'];
		image = jsonRes['image'];
		thumb = jsonRes['thumb'];
	}

	@override
	String toString() {
		return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"image": ${image != null?'${json.encode(image)}':'null'},"thumb": ${thumb != null?'${json.encode(thumb)}':'null'}}';
	}
}

