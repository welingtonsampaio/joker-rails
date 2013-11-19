object @<%= singular_table_name %>
attributes :id , :<%= attributes.dup.delete_if{|c|c.type.to_s == 'references' }.collect{|c|c.name}.join(', :') %>

<% attributes.dup.delete_if{|c|c.type.to_s != 'references' }.each do |attribute| %>
child :<%= attribute.name %> do
  extends "<%= attribute.name.pluralize %>/show"
end
<% end %>