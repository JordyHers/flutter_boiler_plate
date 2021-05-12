
class User{
  final int id;
  final String name;
  final String username;
  final String email;


  User(this.id,this.name,this.username,this.email);


  @override
  String toString() {
    return 'id : $id , name : $name , email: $email, username: $username';
  }
}