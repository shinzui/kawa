class AddRandomValueToQuotes < Mongoid::Migration
  def self.up
    Quote.all.each { |q| q.random = rand; q.timeless.save }
  end

  def self.down
  end
end
