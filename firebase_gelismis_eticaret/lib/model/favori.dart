class Favori {
  dynamic favoriId;

  Favori({this.favoriId});

  factory Favori.fromMap(Map<String, dynamic> map ,{dynamic key}) {
    return Favori(
      favoriId: key ?? map["favoriId"],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      'favoriId': key ?? favoriId,
    };
  }
}
