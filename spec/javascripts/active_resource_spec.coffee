#= require support/sinon-1.7.3
#= require joker
#= require support/address_model
#= require support/user_model
describe "Joker.ActiveResource", ->

  it "deve ser uma herenca de Joker.Core", ->
    expect( Joker.ActiveResource.__super__.accessor("className") ).to.equal "Joker_Core"

  it "deve poder configurar o limite solicitado usando o metodo 'limit'", ->
    users = User.all().limit(12).exec()
    expect( users.count()       ).to.equal 12
    expect( users.offset()      ).to.equal 0
    expect( users.totalCount()  ).to.equal 30
    expect( users.totalPages()  ).to.equal 3
    expect( users.currentPage() ).to.equal 1

  it "deve poder selecionar o numero da pagina da requisicao, os resultados devem ser distintos", ->
    users1 = User.all().limit(5).page(1).exec()
    users2 = User.all().limit(5).page(2).exec()
    for value in users1.source
      for user in users2.source
        expect( value.id() ).to.not.equal user.id()

  it "deve poder interar sobre os resultados utilizando o metodo 'each'", ->
    users = User.all().exec()
    atualId = 0
    users.each (user)->
      expect( user.id() ).to.be.above atualId
      atualId = user.id()

  it "deve poder gerenciar uma ordenacão atraves do metodo 'orderBy'", ->
    users1 = User.all().limit(5).exec()
    users2 = User.all().limit(5).orderBy('name DESC').exec()
    users2.each (u2)->
      users1.each (u1)->
        expect( u2.get('name') ).to.not.equal u1.get('name')

  it "deve poder agrupar os registros retornados, atraves do metodo 'group'", ->
    users = User.all().group("name", "lastname")
    expect( users.conditions.group ).to.include "name"
    expect( users.conditions.group ).to.include "lastname"

  it "deve poder consultar os registros retornados, atraves do metodo 'where'", ->
    users = User.all().where( name: "John" )
    expect( users.conditions.where ).to.include "name = 'John'"

    users = User.all().where( "lastname = 'Smith'" )
    expect( users.conditions.where ).to.include "lastname = 'Smith'"

    users = User.all().where( "birthdate = '{date}'", date: "01-01-1951" )
    expect( users.conditions.where ).to.include "birthdate = '01-01-1951'"

