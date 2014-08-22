Sequel.migration do
  change do
    create_table(:examples) do
      primary_key :id
      String :title
      String :description
      String :statement
    end
  end
end
