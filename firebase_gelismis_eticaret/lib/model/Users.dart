class Users{

   dynamic id;
  final String email;
  final String userName;
   final dynamic profil_url;

  Users({required this.email,required this.id,required this.userName, this.profil_url});

  factory Users.frommap(Map<String,dynamic>json,{dynamic key}){
    return Users(
        email: json["email"],
        id: key ?? json["id"],
        userName: json["userName"],
       profil_url: json["profil_url"] ?? 'boş'
    );
  }

  Map<String,dynamic>toMap({dynamic key}) {
    return {
      'id': id ?? id,
      'email': email,
      'userName':userName,
      'profil_url':profil_url ?? 'boş',
    };
  }
}