module Kawa
  module Mongo
    module Sequence
      extend self

      COLLECTION = "sequences".freeze

      def next(namespace)
        update = {"$inc"  => {next: 1}}
        collection = Mongoid.default_session[COLLECTION]
        collection.find(_id: namespace).modify(update, {upsert: true, new: true})["next"]
      end

    end
  end
end
