
class window.User extends Joker.Model
  @resourceName: "user"
  @encode "name","login","password"
  #  @association(Address, null)
  @timestamp()

  t: ->
    @accessor "fields"
