module JSONAPI
  # c.f. http://jsonapi.org/format/#document-resource-object-relationships
  class Relationships
    def initialize(relationships_hash, options = {})
      fail InvalidDocument,
           "the value of 'relationships' MUST be an object" unless
        relationships_hash.is_a?(Hash)
      @relationships = {}
      relationships_hash.each do |rel_name, rel_hash|
        @relationships[rel_name.to_s] = Relationship.new(rel_hash, options)
        define_singleton_method(rel_name) do
          @relationships[rel_name.to_s]
        end
      end
    end

    def [](rel_name)
      @relationships[rel_name.to_s]
    end

    def defined?(rel_name)
      @relationships.key?(rel_name.to_s)
    end

    def keys
      @relationships.keys
    end
  end
end
