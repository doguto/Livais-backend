module HashExtension
  def camelize
    transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def to_camelized_json
    camelize.to_json
  end
end

class Hash
  prepend HashExtension
end
