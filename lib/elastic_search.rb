module ElasticSearch
  extend self

  def delete_all_indices
    indices.each { |index| index.delete }
    
  end

  def refresh_all_indices
    indices.each { |index| index.refresh }
  end

  def indices
    @indices ||= begin
      indices = []
      Dir.glob(File.join(Rails.root, "app/models/**/*.rb")).sort.each do |file|
        path_parts = file[0..-4].split('/')
        model_idx = path_parts.index("models") 
        path =  path_parts.slice((model_idx +1)..-1)
        model = path.map(&:camelize).join("::").constantize
        if model < Tire::Model::Search && model.respond_to?(:index_name)
          indices << Tire.index(model.index_name)
        end
      end
      indices  
    end
  end
end
