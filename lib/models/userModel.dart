class User {
  int id;
  String name;
  String email;
  String address;
  String contact;
  String avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.contact,
    this.avatar,
  });

  factory User.fromJson(parsedJson) {
    return User(
        id: parsedJson['id'],
        name: parsedJson['name'],
        email: parsedJson['email'],
        address: parsedJson['address'],
        contact: parsedJson['contact'],
        avatar: parsedJson['avatar']);
  }
}
