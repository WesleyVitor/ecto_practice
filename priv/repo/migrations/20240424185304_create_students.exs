defmodule School.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :age, :integer

      timestamps()
    end
  end
end
