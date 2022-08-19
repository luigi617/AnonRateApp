dynamic mapGet(Object? map, dynamic key, {dynamic defaultValue}) {
  if (map is Map){
    if (map.containsKey(key)) {
      return map[key];
    }
  }
  return defaultValue;
}
String dateCreatedParse(String dateCreated){
    DateTime createdAt = DateTime.parse(dateCreated);
    Duration difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 30){
      return "${difference.inDays ~/ 30} months ago";
    } else if (difference.inDays > 0){
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0){
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0){
      return "${difference.inMinutes} minutes ago";
    } else {
      return "${difference.inSeconds} seconds ago";

    }
  }