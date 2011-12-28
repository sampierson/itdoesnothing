# RSpec matcher to spec serialized ActiveRecord attributes.
# Based on a broken version at: https://gist.github.com/842004
#
# Usage:
#
#     describe Post do
#       it { should serialize_attribute(:data) }                 # serialize :data
#       it { should serialize_attribute(:registers).as(Array) }  # serialize :registers, Array
#       it { should serialize_attribute(:options).as(Hash) }     # serialize :options, Hash
#     end

RSpec::Matchers.define :serialize_attribute do |attribute|
  chain(:as) { |type| @as = type }

  match do |model|
    @model = model.is_a?(Class) ? model : model.class
    @serialized_attr = @model.serialized_attributes[attribute.to_s]

    if @as
      @serialized_attr && @serialized_attr.object_class == @as
    else
      @model.serialized_attributes.keys.include?(attribute.to_s)
    end
  end

  description do
    "serialize :#{attribute}" << (@as ? " as a #{@as}" : "")
  end

  failure_message_for_should do |text|
    message = "expected #{@model} to serialize :#{attribute}"
    message << (@as ? " as a #{@as} (is #{@serialized_attr.object_class})" : "") if @serialized_attr
    message
  end

  failure_message_for_should_not do |text|
    "expected #{@model} not to serialize :#{attribute}" << (@as ? " as a #{@as}" : "")
  end
end
