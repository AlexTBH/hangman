require 'yaml'

module BasicSerializable

    @@serializer = YAML

    def serialize
        obj = {}
        instance_variables.map do |var|
            obj[var] = instance_variable_get(var)
        end

        @@serializer.dump obj
    end

    def unserialize
        
    end
end