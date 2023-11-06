namespace :question do
  require 'csv'
  require 'pdf-reader'
  require 'dotenv/load'
  require 'tokenizers'

  COMPLETIONS_MODEL = "text-davinci-003"
  MODEL_NAME = "curie"
  DOC_EMBEDDINGS_MODEL = "text-search-#{MODEL_NAME}-doc-001"
  @tokenizer = Tokenizers.from_pretrained("gpt2")

  desc 'Convert PDF to Embeddings'
  task :convert_pdf_to_embeddings, [:pdf_filename] => :environment do |t, args|

    reader = PDF::Reader.new(args[:pdf_filename])
    res = []

    reader.pages.each_with_index do |page, index|
      res += extract_pages(page.text, index + 1)
    end

    csv_filename = 'book2.pdf.pages.csv'
    CSV.open(csv_filename, 'wb') do |csv|
      csv << ["title", "content", "tokens"]
      res.each do |row|
        csv << row if row[2] < 2046
      end
    end

    convert_csv_to_embeddings(Rails.root.join(csv_filename))
    
  end 

  desc 'Convert CSV to Embeddings'
  task :convert_csv_to_embeddings, [:csv_filename] => :environment do |t, args|
    require 'dotenv/load'
    convert_csv_to_embeddings(Rails.root.join(args[:csv_filename]))
  end 

  def convert_csv_to_embeddings(csv_filename)
    csv = CSV.read(csv_filename, headers: true)
    doc_embeddings = compute_doc_embeddings(csv)
    save_doc_embeddings(doc_embeddings)
  end

  def save_doc_embeddings(doc_embeddings)
    CSV.open(Rails.root.join('book2.pdf.embeddings.csv'), 'wb') do |csv|
      csv << ['title'] + (0..4095).to_a
      
      doc_embeddings.each_with_index do |(index, embedding), i|
        csv << ["Page #{i + 1}"] + embedding
      end
    end
  end

  def count_tokens(text)
    @tokenizer.encode(text).ids.length
  end

  def extract_pages(page_text, index)
    return [] if page_text.empty?
    
    content = page_text.split.join(" ")
    [["Page #{index}", content, count_tokens(content) + 4]]
  end

  def compute_doc_embeddings(df)
    embeddings = {}
    openai_client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    df.each_with_index do |row, idx|
      embeddings[idx] = EmbeddingService.get_doc_embedding(row["content"], openai_client)
    end
    embeddings
  end

end