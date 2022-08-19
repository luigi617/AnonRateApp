class UserBase {
  final int id;
  final String username;
  final String lastName;
  final String firstName;
  final String avatarThumbnail;

  UserBase({
    required this.id,
    required this.username,
    this.lastName = "",
    this.firstName = "",
    this.avatarThumbnail = "",
  });

  factory UserBase.fromJson(Map json) {
    return UserBase(
      id: json['id'],
      username: json["username"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      avatarThumbnail: json["avatar_thumbnail"],
    );
  }
}
class UserList {
  final int id;
  final String username;
  final String lastName;
  final String firstName;
  final String avatarThumbnail;
  final String rate;

  UserList({
    required this.id,
    required this.username,
    this.lastName = "",
    this.firstName = "",
    this.avatarThumbnail = "",
    this.rate = "no rates",
  });

  factory UserList.fromJson(Map json) {
    return UserList(
      id: json['id'],
      username: json["username"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      avatarThumbnail: json["avatar_thumbnail"] ?? "",
      rate: json["rate"],
    );
  }
}