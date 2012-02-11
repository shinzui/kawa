class MoveQuotes < Mongoid::Migration
  def self.up
    Mongoid.database.collection("snippets").update({}, {"$unset" => { "_type" => true } }, :multi => true) 
    Mongoid.database.rename_collection("snippets", "quotes")
    Mongoid.database.rename_collection("snippets_tags_aggregation", "quotes_tags_aggregation")
  end

  def self.down
    Mongoid.database.rename_collection("quotes", "snippets")
    Mongoid.database.rename_collection("quotes_tags_aggregation", "snippets_tags_aggregation")
    Mongoid.database.collection("snippets").update({}, {"$set" => { "_type" => "Quote" } }, :multi => true) 
  end
end
