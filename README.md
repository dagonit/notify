# README

## Using serializer

For existing models, create a serializer to restrict attributes in response.
* rails g serializer existing_model
* add attributes to serializer
``` ruby
class ExistingModelSerializer < ActiveModel::Serializer
  attributes :attribute1, :attribute2
end'
