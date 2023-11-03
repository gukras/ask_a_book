namespace :question do
  require 'csv'
  require 'pdf-reader'
  #require 'net/http'
  #require 'json'
  require 'dotenv/load'
  require "ruby/openai"

  COMPLETIONS_MODEL = "text-davinci-003"
  DOC_EMBEDDINGS_MODEL = "text-embedding-ada-002" 

  desc 'Convert PDF to Embeddings'
  task :convert_pdf_to_embeddings, [:pdf] => :environment do |t, args|

    tokenizer = GPT2TokenizerFast.from_pretrained("gpt2")
    reader = PDF::Reader.new(args[:pdf])
    res = []

    reader.pages.each_with_index do |page, index|
      res += extract_pages(page.text, index + 1)
    end

    # Filter and save as CSV
    csv_filename = 'book.pdf.pages.csv'
    CSV.open(csv_filename, 'wb') do |csv|
      csv << ["title", "content", "tokens"]
      res.each do |row|
        csv << row if row[2] < 2046
      end
    end

    doc_embeddings = compute_doc_embeddings(csv)
    save_doc_embeddings(doc_embeddings)
    
  end 

  desc 'Convert CSV to Embeddings'
  task :convert_csv_to_embeddings, [:csv] => :environment do |t, args|
    require 'dotenv/load'
    csv = CSV.read(Rails.root.join(args[:csv]), headers: true)
    doc_embeddings = compute_doc_embeddings(csv)
    save_doc_embeddings(doc_embeddings)
    
  end 

  def save_doc_embeddings(doc_embeddings)
    CSV.open(Rails.root.join('book.pdf.embeddings.csv'), 'wb') do |csv|
      csv << ['title'] + (0..4095).to_a
      
      doc_embeddings.each_with_index do |(index, embedding), i|
        csv << ["Page #{i + 1}"] + embedding
      end
    end
  end

  # Placeholder tokenizer function (this will not behave exactly like GPT2TokenizerFast from transformers)
  def count_tokens(text)
    text.split.size
  end

  def extract_pages(page_text, index)
    return [] if page_text.empty?

    content = page_text.split.join(" ")
    [["Page #{index}", content, count_tokens(content) + 4]]
  end

  def get_embedding(text, model)
    openai = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    result = openai.embeddings( parameters: {
        model: model,
        input: text
      }
    )
    result["data"][0]["embedding"]
  end

  def get_doc_embedding(text)
    get_embedding(text, DOC_EMBEDDINGS_MODEL)
  end

  def compute_doc_embeddings(df)
    # Create an embedding for each row in the dataframe using the OpenAI Embeddings API.
    # Return a hash that maps between each embedding vector and the index of the row that it corresponds to.   
    embeddings = {}
    df.each_with_index do |row, idx|
      embeddings[idx] = get_doc_embedding(row["content"])
    end
    embeddings
  end

end