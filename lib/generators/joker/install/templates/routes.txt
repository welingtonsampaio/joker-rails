<%= '<%' %> environment.context_class.instance_eval { include Rails.application.routes.url_helpers } %>
App.Routes =
  keep: true # remove this line
