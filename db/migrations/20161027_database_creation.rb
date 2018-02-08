# encoding: utf-8

# rm database.sqlite ; sequel -m migrations/ sqlite://database.sqlite --trace
# 


Sequel.migration do

  up do

    create_table(:model_examples) do
      primary_key :id
      String :title_en
      String :title_es

      DateTime :created_at, :default => DateTime.now
      DateTime :updated_at, :default => DateTime.now
    end

    models = DB[:model_examples]
    models.insert(:title_en => 'hello_world',:title_es => 'hola mundo!')
    models.insert(:title_en => 'first post',:title_es => 'primer articulo')

  end


  down do
    drop_table(:model_examples)
    #TO DO
  end


end
