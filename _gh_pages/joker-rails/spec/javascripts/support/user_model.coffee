
class window.User extends Joker.Model
  @fields = new Object
  @resourceName: "user"
  @uri         : "/users"


  @encode "name", "lastname", "email"
  @association(Address, @HAS_ONE)
  @timestamp()


