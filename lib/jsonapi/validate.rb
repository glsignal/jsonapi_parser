module JSONAPI
  module_function

  # Validate a JSON API document.
  #
  # @param (see #parse)
  # @return [Boolean]
  def validate(document, options = {})
    parse(document, options)

    true
  rescue InvalidDocument => reason
    yield reason if block_given?

    false
  end
end
