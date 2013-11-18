object @state
attributes :id, :name, :acronym, :status

child :country do
  extends "countries/show"
end