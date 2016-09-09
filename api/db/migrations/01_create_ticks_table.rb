Sequel.migration do
  transaction

  change do
    create_table(:ticks) do
      primary_key :id
      Integer :ticks
      DateTime :updated_at
    end
  end
end
