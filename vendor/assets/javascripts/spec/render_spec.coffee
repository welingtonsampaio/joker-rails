describe "Joker.Render", ->
  render = null

  beforeEach ->
    Joker.debug = true
    render = Joker.Render.get_instance()

  afterEach ->
    Joker.debug = false

  it "must be an instance of Core", ->
    expect( Joker.Render.__super__.name ).toEqual "Core"

  it "should generate just a single instance of Render through the static method get_instance", ->
    expect( Joker.Render.get_instance() ).toEqual Joker.Render.get_instance()

#    a = $ "<a />", {text: "sd", id:"asd", "data-render":true}
#    $("html").append a
