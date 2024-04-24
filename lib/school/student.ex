defmodule School.Student do
  use Ecto.Schema

  schema "students" do
    field :name, :string
    field :age, :integer

    many_to_many :subjects, School.Subject, join_through: "students_subjects"

    timestamps()
  end
end
