class ModelExample < Sequel::Model(:model_examples)

  set_schema do

    primary_key :id

    String :title_en, :unique => true
    String :title_es, :unique => true
    
    DateTime :created_at, :default => DateTime.now
    DateTime :updated_at, :default => DateTime.now
    
  end

  #one_to_many :activity_img


  
  def validate
    super    
    errors.add(:title_en, "the title can not be empty.") if title_en.empty?
    errors.add(:title_es, "El titulo no debe estar vacio.") if title_es.empty?
  end
  

end 
  
