class CommentsEntity {
	int total;
	List<CommantsBeanCommants> comments;
	int nextStart;
	CommentsBeanSubject subject;
	int count;
	int start;

	CommentsEntity({this.total, this.comments, this.nextStart, this.subject, this.count, this.start});

	CommentsEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['comments'] != null) {
			comments = new List<CommantsBeanCommants>();
			json['comments'].forEach((v) { comments.add(new CommantsBeanCommants.fromJson(v)); });
		}
		nextStart = json['next_start'];
		subject = json['subject'] != null ? new CommentsBeanSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
		data['next_start'] = this.nextStart;
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		return data;
	}
}

class CommantsBeanCommants {
	String subjectId;
	CommentsBeanCommentsAuthor author;
	CommentsBeanCommentsRating rating;
	String createdAt;
	String id;
	int usefulCount;
	String content;

	CommantsBeanCommants({this.subjectId, this.author, this.rating, this.createdAt, this.id, this.usefulCount, this.content});

	CommantsBeanCommants.fromJson(Map<String, dynamic> json) {
		subjectId = json['subject_id'];
		author = json['author'] != null ? new CommentsBeanCommentsAuthor.fromJson(json['author']) : null;
		rating = json['rating'] != null ? new CommentsBeanCommentsRating.fromJson(json['rating']) : null;
		createdAt = json['created_at'];
		id = json['id'];
		usefulCount = json['useful_count'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['subject_id'] = this.subjectId;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['created_at'] = this.createdAt;
		data['id'] = this.id;
		data['useful_count'] = this.usefulCount;
		data['content'] = this.content;
		return data;
	}
}

class CommentsBeanCommentsAuthor {
	String uid;
	String signature;
	String alt;
	String name;
	String avatar;
	String id;

	CommentsBeanCommentsAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	CommentsBeanCommentsAuthor.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		signature = json['signature'];
		alt = json['alt'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['signature'] = this.signature;
		data['alt'] = this.alt;
		data['name'] = this.name;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		return data;
	}
}

class CommentsBeanCommentsRating {
	var min;
	var max;
	var value;

	CommentsBeanCommentsRating({this.min, this.max, this.value});

	CommentsBeanCommentsRating.fromJson(Map<String, dynamic> json) {
		min = json['min'];
		max = json['max'];
		value = json['value'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['min'] = this.min;
		data['max'] = this.max;
		data['value'] = this.value;
		return data;
	}
}

class CommentsBeanSubject {
	CommentsBeanSubjectImages images;
	String originalTitle;
	String year;
	List<CommantsBeanSubjectDirectors> directors;
	CommentsBeanSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<CommantsBeanSubjectCasts> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	CommentsBeanSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	CommentsBeanSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new CommentsBeanSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<CommantsBeanSubjectDirectors>();
			json['directors'].forEach((v) { directors.add(new CommantsBeanSubjectDirectors.fromJson(v)); });
		}
		rating = json['rating'] != null ? new CommentsBeanSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = new List<CommantsBeanSubjectCasts>();
			json['casts'].forEach((v) { casts.add(new CommantsBeanSubjectCasts.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		durations = json['durations'].cast<String>();
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
		data['pubdates'] = this.pubdates;
		if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
		data['durations'] = this.durations;
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class CommentsBeanSubjectImages {
	String small;
	String large;
	String medium;

	CommentsBeanSubjectImages({this.small, this.large, this.medium});

	CommentsBeanSubjectImages.fromJson(Map<String, dynamic> json) {
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

class CommantsBeanSubjectDirectors {
	String name;
	String alt;
	String id;
	CommentsBeanSubjectDirectorsAvatars avatars;
	String nameEn;

	CommantsBeanSubjectDirectors({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantsBeanSubjectDirectors.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CommentsBeanSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class CommentsBeanSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	CommentsBeanSubjectDirectorsAvatars({this.small, this.large, this.medium});

	CommentsBeanSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class CommentsBeanSubjectRating {
	var average;
	var min;
	var max;
	CommentsBeanSubjectRatingDetails details;
	String stars;

	CommentsBeanSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	CommentsBeanSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new CommentsBeanSubjectRatingDetails.fromJson(json['details']) : null;
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

class CommentsBeanSubjectRatingDetails {
	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	CommentsBeanSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	CommentsBeanSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class CommantsBeanSubjectCasts {
	String name;
	String alt;
	String id;
	CommentsBeanSubjectCastsAvatars avatars;
	String nameEn;

	CommantsBeanSubjectCasts({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantsBeanSubjectCasts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CommentsBeanSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class CommentsBeanSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	CommentsBeanSubjectCastsAvatars({this.small, this.large, this.medium});

	CommentsBeanSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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
