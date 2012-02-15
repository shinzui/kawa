module Kawa
  module Mongo
    module Sequence
      extend self

      COLLECTION = "sequences"

      def next(namespace)
        query = {_id: namespace}
        update = {"$inc"  => {next: 1}}
        options = {:query  => query, :update  => update, :upsert  => true, :new  => true}
        collection = Mongoid.master.collection(COLLECTION)
        collection.find_and_modify(options)["next"]
      end

    end
  end
end
