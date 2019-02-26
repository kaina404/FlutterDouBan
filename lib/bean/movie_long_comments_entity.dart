class MovieLongCommentsEntity {
	int total;
	int nextStart;
	List<MovieLongCommentReviews> reviews;
	MovieLongCommentsSubject subject;
	int count;
	int start;

	MovieLongCommentsEntity({this.total, this.nextStart, this.reviews, this.subject, this.count, this.start});

	MovieLongCommentsEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		nextStart = json['next_start'];
		if (json['reviews'] != null) {
			reviews = new List<MovieLongCommentReviews>();
			json['reviews'].forEach((v) { reviews.add(new MovieLongCommentReviews.fromJson(v)); });
		}
		subject = json['subject'] != null ? new MovieLongCommentsSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['next_start'] = this.nextStart;
		if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		return data;
	}
}

class MovieLongCommentReviews {
	String summary;
	String subjectId;
	MovieLongCommentsReviewsAuthor author;
	MovieLongCommentsReviewsRating rating;
	String alt;
	String createdAt;
	String title;
	int uselessCount;
	String content;
	String updatedAt;
	String shareUrl;
	int commentsCount;
	String id;
	int usefulCount;

	MovieLongCommentReviews({this.summary, this.subjectId, this.author, this.rating, this.alt, this.createdAt, this.title, this.uselessCount, this.content, this.updatedAt, this.shareUrl, this.commentsCount, this.id, this.usefulCount});

	MovieLongCommentReviews.fromJson(Map<String, dynamic> json) {
		summary = json['summary'];
		subjectId = json['subject_id'];
		author = json['author'] != null ? new MovieLongCommentsReviewsAuthor.fromJson(json['author']) : null;
		rating = json['rating'] != null ? new MovieLongCommentsReviewsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		createdAt = json['created_at'];
		title = json['title'];
		uselessCount = json['useless_count'];
		content = json['content'];
		updatedAt = json['updated_at'];
		shareUrl = json['share_url'];
		commentsCount = json['comments_count'];
		id = json['id'];
		usefulCount = json['useful_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['summary'] = this.summary;
		data['subject_id'] = this.subjectId;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['alt'] = this.alt;
		data['created_at'] = this.createdAt;
		data['title'] = this.title;
		data['useless_count'] = this.uselessCount;
		data['content'] = this.content;
		data['updated_at'] = this.updatedAt;
		data['share_url'] = this.shareUrl;
		data['comments_count'] = this.commentsCount;
		data['id'] = this.id;
		data['useful_count'] = this.usefulCount;
		return data;
	}
}

class MovieLongCommentsReviewsAuthor {
	String uid;
	String signature;
	String alt;
	String name;
	String avatar;
	String id;

	MovieLongCommentsReviewsAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	MovieLongCommentsReviewsAuthor.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsReviewsRating {
	var min;
	var max;
	var value;

	MovieLongCommentsReviewsRating({this.min, this.max, this.value});

	MovieLongCommentsReviewsRating.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsSubject {
	MovieLongCommentsSubjectImages images;
	String originalTitle;
	String year;
	List<MovieLongCommantsSubjectDirectors> directors;
	MovieLongCommentsSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<MovieLongCommantsSubjectCasts> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	MovieLongCommentsSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	MovieLongCommentsSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new MovieLongCommentsSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<MovieLongCommantsSubjectDirectors>();
			json['directors'].forEach((v) { directors.add(new MovieLongCommantsSubjectDirectors.fromJson(v)); });
		}
		rating = json['rating'] != null ? new MovieLongCommentsSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = new List<MovieLongCommantsSubjectCasts>();
			json['casts'].forEach((v) { casts.add(new MovieLongCommantsSubjectCasts.fromJson(v)); });
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

class MovieLongCommentsSubjectImages {
	String small;
	String large;
	String medium;

	MovieLongCommentsSubjectImages({this.small, this.large, this.medium});

	MovieLongCommentsSubjectImages.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommantsSubjectDirectors {
	String name;
	String alt;
	String id;
	MovieLongCommentsSubjectDirectorsAvatars avatars;
	String nameEn;

	MovieLongCommantsSubjectDirectors({this.name, this.alt, this.id, this.avatars, this.nameEn});

	MovieLongCommantsSubjectDirectors.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieLongCommentsSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class MovieLongCommentsSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	MovieLongCommentsSubjectDirectorsAvatars({this.small, this.large, this.medium});

	MovieLongCommentsSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsSubjectRating {
	double average;
	int min;
	int max;
	MovieLongCommentsSubjectRatingDetails details;
	String stars;

	MovieLongCommentsSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	MovieLongCommentsSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new MovieLongCommentsSubjectRatingDetails.fromJson(json['details']) : null;
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

class MovieLongCommentsSubjectRatingDetails {
	double d1;
	double d2;
	double d3;
	double d4;
	double d5;

	MovieLongCommentsSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	MovieLongCommentsSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommantsSubjectCasts {
	String name;
	String alt;
	String id;
	MovieLongCommentsSubjectCastsAvatars avatars;
	String nameEn;

	MovieLongCommantsSubjectCasts({this.name, this.alt, this.id, this.avatars, this.nameEn});

	MovieLongCommantsSubjectCasts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieLongCommentsSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class MovieLongCommentsSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	MovieLongCommentsSubjectCastsAvatars({this.small, this.large, this.medium});

	MovieLongCommentsSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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
