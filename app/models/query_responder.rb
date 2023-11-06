require 'ruby/openai'

class QueryResponder
    MAX_SECTION_LEN = 500
    SEPARATOR = "\n* "
    SEPARATOR_LEN = 3
    COMPLETIONS_MODEL = "text-davinci-003"
    COMPLETIONS_API_PARAMS = {
        "temperature": 0.0,
        "max_tokens": 150,
        "model": COMPLETIONS_MODEL,
    }

    class << self
        def answer_query_with_context(question)
            openai_client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
            df = CSV.read('book.pdf.pages.csv', headers: true)
            document_embeddings = load_embeddings('book.pdf.embeddings.csv')
            prompt, context = construct_prompt(question, document_embeddings, df, openai_client)
        
            #A better solution would only use one client for the entire application, but this is a quick solution to get the code working as i don't expect high traffic.
            response = openai_client.completions( parameters: {
                    prompt: prompt,
                    **COMPLETIONS_API_PARAMS
                }    
            )
        
            [response['choices'].first['text'].strip, context]
        end

        private
    
        def load_embeddings(file_name)
            embeddings = {}
            CSV.foreach(file_name, headers: true) do |row|
            title = row['title']
            embeddings[title] = row.to_h.except('title').values.map(&:to_f)
            end
            embeddings
        end 

        def construct_prompt(question, context_embeddings, df, openai_client)
            query_embedding = EmbeddingService.get_query_embedding(question, openai_client)
            most_relevant_document_sections = DocumentSectionOrderer.document_sections_by_query_similarity(query_embedding, context_embeddings)

            chosen_sections = []
            chosen_sections_len = 0
            chosen_sections_indexes = []

            most_relevant_document_sections.each do |_, section_index|
            document_section = df.find { |row| row['title'] == section_index }
            chosen_sections_len += document_section['tokens'].to_i + SEPARATOR_LEN
            
            if chosen_sections_len > MAX_SECTION_LEN
                space_left = MAX_SECTION_LEN - chosen_sections_len - SEPARATOR_LEN
                chosen_sections.append(SEPARATOR + document_section['content'][0...space_left])
                chosen_sections_indexes.append(section_index.to_s)
                break
            end

            chosen_sections.append(SEPARATOR + document_section['content'])
            chosen_sections_indexes.append(section_index.to_s)
            end

            header = """Sahil Lavingia is the founder and CEO of Gumroad, and the author of the book The Minimalist Entrepreneur (also known as TME). These are questions and answers by him. Please keep your answers to three sentences maximum, and speak in complete sentences. Stop speaking once your point is made.\n\nContext that may be useful, pulled from The Minimalist Entrepreneur:\n"""
            
            prompt = header + chosen_sections.join + predefined_questions.join + "\n\n\nQ: #{question}\n\nA: "
            
            [prompt, chosen_sections.join]
        end


        def predefined_questions
            predefined_questions = []
            predefined_questions.append("\n\n\nQ: How to choose what business to start?\n\nA: First off don't be in a rush. Look around you, see what problems you or other people are facing, and solve one of these problems if you see some overlap with your passions or skills. Or, even if you don't see an overlap, imagine how you would solve that problem anyway. Start super, super small.")
            predefined_questions.append("\n\n\nQ: Q: Should we start the business on the side first or should we put full effort right from the start?\n\nA:   Always on the side. Things start small and get bigger from there, and I don't know if I would ever “fully” commit to something unless I had some semblance of customer traction. Like with this product I'm working on now!")
            predefined_questions.append("\n\n\nQ: Should we sell first than build or the other way around?\n\nA: I would recommend building first. Building will teach you a lot, and too many people use “sales” as an excuse to never learn essential skills like building. You can't sell a house you can't build!")
            predefined_questions.append("\n\n\nQ: Andrew Chen has a book on this so maybe touché, but how should founders think about the cold start problem? Businesses are hard to start, and even harder to sustain but the latter is somewhat defined and structured, whereas the former is the vast unknown. Not sure if it's worthy, but this is something I have personally struggled with\n\nA: Hey, this is about my book, not his! I would solve the problem from a single player perspective first. For example, Gumroad is useful to a creator looking to sell something even if no one is currently using the platform. Usage helps, but it's not necessary.")
            predefined_questions.append("\n\n\nQ: What is one business that you think is ripe for a minimalist Entrepreneur innovation that isn't currently being pursued by your community?\n\nA: I would move to a place outside of a big city and watch how broken, slow, and non-automated most things are. And of course the big categories like housing, transportation, toys, healthcare, supply chain, food, and more, are constantly being upturned. Go to an industry conference and it's all they talk about! Any industry…")
            predefined_questions.append("\n\n\nQ: How can you tell if your pricing is right? If you are leaving money on the table\n\nA: I would work backwards from the kind of success you want, how many customers you think you can reasonably get to within a few years, and then reverse engineer how much it should be priced to make that work.")
            predefined_questions.append("\n\n\nQ: Why is the name of your book 'the minimalist entrepreneur' \n\nA: I think more people should start businesses, and was hoping that making it feel more “minimal” would make it feel more achievable and lead more people to starting-the hardest step.")
            predefined_questions.append("\n\n\nQ: How long it takes to write TME\n\nA: About 500 hours over the course of a year or two, including book proposal and outline.")
            predefined_questions.append("\n\n\nQ: What is the best way to distribute surveys to test my product idea\n\nA: I use Google Forms and my email list / Twitter account. Works great and is 100% free.")
            predefined_questions.append("\n\n\nQ: How do you know, when to quit\n\nA: When I'm bored, no longer learning, not earning enough, getting physically unhealthy, etc… loads of reasons. I think the default should be to “quit” and work on something new. Few things are worth holding your attention for a long period of time.")
            return predefined_questions
        end
    end
end