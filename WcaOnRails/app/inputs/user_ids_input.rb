class UserIdsInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] << "wca-autocomplete wca-autocomplete-users_search"
    if @options[:only_delegates]
      merged_input_options[:class] << "wca-autocomplete-only_delegates"
    end
    if @options[:persons_table]
      merged_input_options[:class] << "wca-autocomplete-persons_table"
      persons = (@builder.object.send(attribute_name) || "").split(",").map { |wca_id| Person.find_by_id(wca_id) }
      merged_input_options[:data] = { data: persons.map(&:to_jsonable).to_json }
    else
      users = (@builder.object.send(attribute_name).to_s || "").split(",").map { |id| User.find_by_id(id) }
      merged_input_options[:data] = { data: users.map(&:to_jsonable).to_json }
    end
    if @options[:only_one]
      merged_input_options[:class] << "wca-autocomplete-only_one"
    end
    @builder.text_field(attribute_name, merged_input_options)
  end
end
