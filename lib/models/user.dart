class User{
  String? username;
  String? firstname;
  String? lastname;

  User({this.username, this.firstname, this.lastname});

  User.fromJson(Map<String, dynamic> json)
  : username = json['username'],
    firstname = json['firstname'],
    lastname = json['lastname'];

}