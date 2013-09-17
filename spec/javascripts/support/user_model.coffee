
class window.User extends Joker.Model
  @fields = new Object
  @resourceName: "user"
  @uri         : "/users"
  @prefixUri   : "/assets/support"


  @encode "name", "lastname", "email"
  @association(Address, @HAS_ONE)
  @timestamp()


