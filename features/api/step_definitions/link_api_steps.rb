def json_response
  JSON.parse(page.driver.response.body)
end

def json_path_expectation(json, path, expectation)
  JsonPath.new(path).on(json).first.should == expectation
end


Then /^the JSON response should have the "(.*?)" object with following attributes:$/ do |obj_name, name_value_pairs|
  obj = instance_variable_get(:"@#{obj_name}") 
  serializer = "#{obj_name.capitalize}Serializer".constantize.new(obj)
  name_value_pairs.hashes.each do |row|
    json_path_expectation(json_response, "$.#{obj_name}.#{row[:attribute]}", serializer.send(row[:attribute]).to_s)
  end
end
