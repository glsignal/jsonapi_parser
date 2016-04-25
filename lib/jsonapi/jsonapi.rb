module JSONAPI
  # c.f. http://jsonapi.org/format/#document-jsonapi-object
  class JsonApi
    attr_reader :version, :meta

    def initialize(jsonapi_hash, options = {})
      fail InvalidDocument, "the value of 'jsonapi' MUST be an object" unless
        jsonapi_hash.is_a?(Hash)
      @version = jsonapi_hash['version'] if jsonapi_hash.key?('meta')
      @meta = jsonapi_hash['meta'] if jsonapi_hash.key?('meta')
    end
  end
end
