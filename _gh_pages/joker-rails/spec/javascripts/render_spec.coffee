#= require support/sinon-1.7.3
#= require joker
#= require support/css
describe "Joker.Render", ->

  render = null
  container = null

  beforeEach ->
    render = Joker.Render.getInstance()
    container = Joker.Core.libSupport "<div />", "data-yield": true
    Joker.Core.libSupport("body").empty().append container

  it "must be an instance of Core", ->
    expect( Joker.Render.__super__.accessor("className") ).to.equal "Joker_Core"

  it "should generate just a single instance of Render through the static method get_instance", ->
    expect( Joker.Render.getInstance() ).to.equal Joker.Render.getInstance()

  it "should append content1.html to data-yield", ->
    a = $ "<a />", text: "link1", "data-jrender":true, href: "/assets/support/content1.html", id: "myLink1"
    a.appendTo container
    render.linkClickRender({currentTarget: a[0]})
    expect( container.html() ).to.equal "<h1>Title 1</h1>"

  it "should append content2.html to data-yield", ->
    a = $ "<a />", text: "link2", "data-jrender":true, href: "/assets/support/content2.html", id: "myLink2"
    a.appendTo container
    render.linkClickRender({currentTarget: a[0]})
    expect( container.html() ).to.equal "<h2>Title 2</h2>"

  it "should create a new window with Xhr content", ->
    a = $ "<a />", text: "link2", "data-jwindow":true, "data-jrender-title":"title test", href: "/assets/support/content2.html", id: "myLink2"
    render.linkClickWindow({currentTarget: a[0]})
    expect( document.body.innerHTML ).to.match /title test/
    expect( document.body.innerHTML ).to.match /<h2>Title 2<\/h2>/



