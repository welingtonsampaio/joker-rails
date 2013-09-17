#= require support/sinon-1.7.3
#= require joker
#= require support/address_model
#= require support/user_model
describe "Joker.Model", ->

  params1 =
    id: 1
    name: "John"
    lastname: "Smith"
    email: "john@smith.com"
    created_at: Date.now()
    updated_at: Date.now()
    address:
      id: 1
      address: "Ruth Street"
      number: "202"
  params2 =
    id: 2
    name: "Mattie"
    lastname: "Peil"
    email: "mattie@peil.com"
    created_at: Date.now()
    updated_at: Date.now()
    address:
      id: 2
      address: "Pearl Street"
      number: "382"

  beforeEach ->
    Joker.debug = no

  afterEach ->
    Joker.debug = no

  it "deve ser uma heranca de Joker.Core", ->
    expect( Joker.Model.__super__.accessor("className") ).to.equal "Joker_Core"

  it "deve poder configurar os campos existente neste modelo, através do metodo 'encode'", ->
    test = User.fromJSON
      name: "John"
      lastname: "Smith"
    expect( test.attributes ).to.include.keys('name')
    expect( test.attributes ).to.include.keys('lastname')

  it "deve poder configurar os campos 'created_at' e 'updated_at', através do metodo 'timestamp'", ->
    class Test extends Joker.Model
      @fields = new Object()
      @timestamp()
    test = Test.fromJSON
      created_at: Date.now()
      updated_at: Date.now()
    expect( test.attributes ).to.include.keys('created_at')
    expect( test.attributes ).to.include.keys('updated_at')

  it "deve poder criar dois objetos com valores diferentes", ->
    user1 = new User()
    user2 = new User()
    user1.set('name', 'Name 1')
    user2.set('name', 'Name 2')
    expect( user1.get('name') ).to.not.equal user2.get('name')

  describe "Metodo estatico 'fromJSON'", ->

    it "deve poder criar um novo objeto atraves de um JSON", =>
      test = User.fromJSON
        created_at: Date.now()
        updated_at: Date.now()
      expect( test.attributes ).to.include.keys('created_at')
      expect( test.attributes ).to.include.keys('updated_at')

    it "deve estourar uma excecao caso seja passado algum valor invalido", =>
      expect( User.fromJSON).throw

  describe "Metodo estatico 'fromForm", ->
    form = """
           <form action="" method="post" data-jokerform data-jokermodel="User">
             <input name="user[name]" />
             <input name="user[lastname]" />
             <button>send</button>
           </form>
           """

    beforeEach =>
      Joker.Core.libSupport('body').empty().html form


    it "deve poder inicializar um objeto atraves de um formulário", =>
      fields = Joker.Core.libSupport("body input")
      fields.first().val "John"
      fields.last().val "Smith"
      model = User.fromForm()
      expect( model.get('name')  ).to.equal "John"
      expect( model.get('lastname') ).to.equal "Smith"

    it "deve verificar se existe um formulario para importacão, caso nao exista estoura uma excessao", ->
      expect( User.hasFormImport()).to.equal yes
      expect( User.fromForm).throw
      Joker.Core.libSupport('body').empty()
      expect( User.hasFormImport()).to.equal no

  describe "Metodos de Associacão", ->

    it "deve poder adicionar associacões atraves do metodo estatico 'association'", ->
      user = new User
      expect( user.get('address').accessor('resourceName')).to.equal 'address'

    it "deve retornar um objeto do tipo Address, rodar metodos encadeados para getters e setters", ->
      user = new User
      user.get('address').set('number', "123456789")
      expect( user.get('address').get('number')).to.equal '123456789'

    it "deve associacoes entre dois objetos distintos", ->
      user1 = new User
      user1.get('address').set('number', "123456789")
      user2 = new User
      user2.get('address').set('number', "987654321")
      expect( user1.get('address').get('number') ).to.not.equal user2.get('address').get('number')

    it "deve criar um objeto usuario e junto adicionar o Address", ->
      user = User.fromJSON params1
      console.log user.get('address')
      expect( user.get('address').get('address') ).to.equal params1.address.address


  describe "User Model Example - support", ->

    it "deve poder requisitar uma lista de usuarios", ->
      u = User.all().exec()
      expect(u.accessor('className')).to.equal 'Joker_ActiveResource'

    it "deve poder requisitar um usuario atraves do ID", ->
      user = User.find(1)
      expect( user.get('name')     ).to.equal "John"
      expect( user.get('lastname') ).to.equal "Smith"
      expect( user.get('id')       ).to.equal 1
      expect( user.get('email')    ).to.equal "John@smith.com"




