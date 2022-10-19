require 'yaml'

module BasicSerializable

    @@serializer = YAML

    def serialize
        obj = {}
        instance_variables.map do |var|
            obj[var] = instance_variable_get(var)
        end

        File.open("hangman.yaml", "w") { |file| file.write(@@serializer.dump(obj)) }

    end

    def unserialize
        obj = YAML.load_file("hangman.yaml")
        obj.keys.each do |key|
            instance_variable_set(key, obj[key])
        end
    end
end