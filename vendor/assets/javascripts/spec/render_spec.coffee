describe "Joker.Render", ->
  render = null
  container = null

  beforeEach ->
    Joker.debug = true
    render = Joker.Render.getInstance()
    container = $ "<div />", "data-yield": true
    $("#spec_container").append container

  afterEach ->
    Joker.debug = false
    $("#spec_container").empty()
    history.replaceState {}, "asd", '/'

  it "must be an instance of Core", ->
    expect( Joker.Render.__super__.name ).toEqual "Core"

  it "should generate just a single instance of Render through the static method get_instance", ->
    expect( Joker.Render.getInstance() ).toEqual Joker.Render.getInstance()

  it "should append content1.html to data-yield", ->
    a = $ "<a />", text: "link1", "data-render":true, href: "/assets/spec/support/content1.html", id: "myLink1"
    a.appendTo container
    render.linkClick({currentTarget: a[0]})
    waitsFor ->
      container.html() == "<h1>Title 1</h1>"
    , "The content should be rendered", 250

  it "should append content2.html to data-yield", ->
    a = $ "<a />", text: "link2", "data-render":true, href: "/assets/spec/support/content2.html", id: "myLink2"
    a.appendTo container
    render.linkClick({currentTarget: a[0]})
    waitsFor ->
      container.html() == "<h2>Title 2</h2>"
    , "The content should be rendered", 250


