class User {
  String uid;
  String email;
  String name;
  String description;
  String status;
  List<String> interests;

  User({
    this.uid, 
    this.email, 
    this.name, 
    this.description, 
    this.status, 
    this.interests
  });

  User.defaultUser(String userUid, String userEmail, String userName) {
    uid = userUid;
    email = userEmail;
    name = userName;
    description = '';
    status = 'Attendee';
    interests = [];
  }
}