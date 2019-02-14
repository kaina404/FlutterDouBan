class CelebrityWorkEntity {
	CelebrityWorkCelebrity celebrity;
	int total;
	List<CelebrityWorkWork> works;
	int count;
	int start;

	CelebrityWorkEntity({this.celebrity, this.total, this.works, this.count, this.start});

	CelebrityWorkEntity.fromJson(Map<String, dynamic> json) {
		celebrity = json['celebrity'] != null ? new CelebrityWorkCelebrity.fromJson(json['celebrity']) : null;
		total = json['total'];
		if (json['works'] != null) {
			works = new List<CelebrityWorkWork>();
			json['works'].forEach((v) { works.add(new CelebrityWorkWork.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.celebrity != null) {
      data['celebrity'] = this.celebrity.toJson();
    }
		data['total'] = this.total;
		if (this.works != null) {
      data['works'] = this.works.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		return data;
	}
}

class CelebrityWorkCelebrity {
	String name;
	String alt;
	String id;
	CelebrityWorkCelebrityAvatars avatars;
	String nameEn;

	CelebrityWorkCelebrity({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkCelebrity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CelebrityWorkCelebrityAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class CelebrityWorkCelebrityAvatars {
	String small;
	String large;
	String medium;

	CelebrityWorkCelebrityAvatars({this.small, this.large, this.medium});

	CelebrityWorkCelebrityAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}

class CelebrityWorkWork {
	CelebrityWorkWorksSubject subject;
	List<String> roles;

	CelebrityWorkWork({this.subject, this.roles});

	CelebrityWorkWork.fromJson(Map<String, dynamic> json) {
		subject = json['subject'] != null ? new CelebrityWorkWorksSubject.fromJson(json['subject']) : null;
		roles = json['roles'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['roles'] = this.roles;
		return data;
	}
}

class CelebrityWorkWorksSubject {
	CelebrityWorkWorksSubjectImages images;
	String originalTitle;
	String year;
	List<CelebrityWorkWorksSubjectDirector> directors;
	CelebrityWorkWorksSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<CelebrityWorkWorksSubjectCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	CelebrityWorkWorksSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	CelebrityWorkWorksSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new CelebrityWorkWorksSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<CelebrityWorkWorksSubjectDirector>();
			json['directors'].forEach((v) { directors.add(new CelebrityWorkWorksSubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new CelebrityWorkWorksSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'] == null ? null : [];

		for (var pubdatesItem in pubdates == null ? [] : json['pubdates']){
			pubdates.add(pubdatesItem);
		}
		if (json['casts'] != null) {
			casts = new List<CelebrityWorkWorksSubjectCast>();
			json['casts'].forEach((v) { casts.add(new CelebrityWorkWorksSubjectCast.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		durations = json['durations'] == null ? null : [];

		for (var durationsItem in durations == null ? [] : json['durations']){
			durations.add(durationsItem);
		}
		mainlandPubdate = json['mainland_pubdate'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.images != null) {
      data['images'] = this.images.toJson();
    }
		data['original_title'] = this.originalTitle;
		data['year'] = this.year;
		if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['alt'] = this.alt;
		data['title'] = this.title;
		data['collect_count'] = this.collectCount;
		data['has_video'] = this.hasVideo;
//		if (this.pubdates != null) {
//      data['pubdates'] = this.pubdates.map((v) => v.toJson()).toList();
//    }
		if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
//		if (this.durations != null) {
//      data['durations'] = this.durations.map((v) => v.toJson()).toList();
//    }
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class CelebrityWorkWorksSubjectImages {
	String small;
	String large;
	String medium;

	CelebrityWorkWorksSubjectImages({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectImages.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}

class CelebrityWorkWorksSubjectDirector {
	String name;
	String alt;
	String id;
	CelebrityWorkWorksSubjectDirectorsAvatars avatars;
	String nameEn;

	CelebrityWorkWorksSubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkWorksSubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CelebrityWorkWorksSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class CelebrityWorkWorksSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	CelebrityWorkWorksSubjectDirectorsAvatars({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}

class CelebrityWorkWorksSubjectRating {
	var average;
	var min;
	var max;
	CelebrityWorkWorksSubjectRatingDetails details;
	String stars;

	CelebrityWorkWorksSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	CelebrityWorkWorksSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new CelebrityWorkWorksSubjectRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
		if (this.details != null) {
      data['details'] = this.details.toJson();
    }
		data['stars'] = this.stars;
		return data;
	}
}

class CelebrityWorkWorksSubjectRatingDetails {
	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	CelebrityWorkWorksSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	CelebrityWorkWorksSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
		d1 = json['1'];
		d2 = json['2'];
		d3 = json['3'];
		d4 = json['4'];
		d5 = json['5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['1'] = this.d1;
		data['2'] = this.d2;
		data['3'] = this.d3;
		data['4'] = this.d4;
		data['5'] = this.d5;
		return data;
	}
}

class CelebrityWorkWorksSubjectCast {
	String name;
	String alt;
	String id;
	CelebrityWorkWorksSubjectCastsAvatars avatars;
	String nameEn;

	CelebrityWorkWorksSubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkWorksSubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CelebrityWorkWorksSubjectCastsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class CelebrityWorkWorksSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	CelebrityWorkWorksSubjectCastsAvatars({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}
