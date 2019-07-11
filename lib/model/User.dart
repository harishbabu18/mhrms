class User{
  /*final int userId;
  final int id;
  final String title;
  final String body;

  User({this.userId, this.id, this.title, this.body});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }*/

final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;

  User({this.id, this.firstName, this.lastName, this.email, this.mobile,
    this.password});
  factory User.fromJson(Map<String,dynamic> json){
    return User(id:json['id'],
                firstName: json['firstName'],
                lastName: json['lastName'],
                email: json['email'],
                mobile: json['mobile'],
                password: json['password'],);

  }
Map toMap() {
  var map = new Map<String, dynamic>();
  map["id"] = id;
  map["firstName"] = firstName;
  map["lastName"] = lastName;
  map["email"] = email;
  map["mobile"] = mobile;
  map["password"] = password;

  return map;
}
}