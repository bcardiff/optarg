module Optarg
  class Parser
    def parse(model, data)
      argument_index = 0
      args = data.__args_to_be_parsed

      model.__options.values.each do |option|
        option.set_default_to data
      end

      model.__arguments.values.each do |argument|
        argument.set_default_to data
      end

      index = 0
      while index < args.size
        i = index
        arg = args[i]
        if arg =~ /^-\w\w/
          letters = arg[1..-1].split("").map{|i| "-#{i}"}
          matched = true
          letters.each do |letter|
            (model.__options.values + model.__handlers.values).each do |definition|
              break if matched = definition.parse(letter, data)
            end
            raise ::Optarg::UnknownOption.new(letter) unless matched
          end
          data.__parsed_nodes << [arg]
          i += 1
        else
          (model.__options.values + model.__handlers.values).each do |definition|
            j = definition.parse(args, i, data)
            if j != i
              data.__parsed_nodes << args[i..(j-1)]
              i = j
              break
            end
          end
          if i == index
            raise ::Optarg::UnknownOption.new(args[i]) if args[i].starts_with?("-")
            if argument_index < model.__arguments.size
              data.__parsed_args.__named[model.__arguments.values[argument_index].key] = args[i]
              data.__parsed_args << args[i]
              argument_index += 1
            else
              data.__parsed_args.__nameless << args[i]
              data.__parsed_args << args[i]
            end
            data.__parsed_nodes << [args[i]]
            i += 1
          end
        end
        index = i
      end

      model.__options.values.each do |option|
        option.validate data
      end

      model.__arguments.values.each do |argument|
        argument.validate data
      end
    end
  end
end
