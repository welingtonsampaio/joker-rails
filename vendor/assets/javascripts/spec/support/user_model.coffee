
class window.User extends Joker.Model

  @resourceName: "user"
  @uri         : "assets/spec/support/users"


  @encode "name", "lastname", "email"
  #  @association(Address, null)
  @timestamp()

