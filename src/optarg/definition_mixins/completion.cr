module Optarg::DefinitionMixins
  module Completion
    macro included
      module CompletionModule
        abstract def completion_length(gen) : Int32
        abstract def completion_max_occurs(gen) : Int32

        def completion_words(gen) : Array(String)?
        end

        def completion_next_models_by_value(gen) : Hash(String, ModelClass)?
        end
      end

      include CompletionModule
    end
  end
end