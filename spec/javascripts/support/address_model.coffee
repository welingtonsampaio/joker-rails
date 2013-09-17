
class window.Address extends Joker.Model
  @fields      : new Object()
  @resourceName: "address"
  @uri         : "/addresses"
  @prefixUri   : "/assets/support"


  @encode "address", "number"
  #  @association(Address, null)
  #  @timestamp()


