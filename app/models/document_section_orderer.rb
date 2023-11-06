class DocumentSectionOrderer
    
    class << self
        def document_sections_by_query_similarity(query_embedding, contexts)
            document_similarities = contexts.map do |doc_index, doc_embedding|
                [vector_similarity(query_embedding, doc_embedding), doc_index]
            end
        
            document_similarities.sort_by { |similarity, _| -similarity }
        end
    
        private
  
        # Calculate vector similarity, implemented as cosine similarity
        def vector_similarity(x, y)
            dot_product = x.zip(y).map { |a, b| a * b }.reduce(:+)
            magnitude_of_x = Math.sqrt(x.map { |n| n**2 }.reduce(:+))
            magnitude_of_y = Math.sqrt(y.map { |n| n**2 }.reduce(:+))
            
            dot_product / (magnitude_of_x * magnitude_of_y)
        end
    end
end