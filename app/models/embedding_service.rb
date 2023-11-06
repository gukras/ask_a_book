require 'ruby/openai'

class EmbeddingService
    MODEL_NAME = "curie"
    DOC_EMBEDDINGS_MODEL = "text-search-#{MODEL_NAME}-doc-001"
    QUERY_EMBEDDINGS_MODEL = "text-search-#{MODEL_NAME}-query-001"

    class << self
        def get_doc_embedding(text, openai_client)
            get_embedding(text, DOC_EMBEDDINGS_MODEL, openai_client)
        end

        def get_query_embedding(text, openai_client)
            get_embedding(text, QUERY_EMBEDDINGS_MODEL, openai_client)
        end
      
        private 
  
        def get_embedding(text, model, openai_client)
            response = openai_client.embeddings( parameters: {
                    model: model,
                    input: text
                }
            )
            response["data"].first["embedding"]
        end  
    end    
end