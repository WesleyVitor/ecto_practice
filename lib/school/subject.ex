defmodule School.Subject do
  use Ecto.Schema

  schema "subjects" do
    field :name, :string

    many_to_many :students, School.Student, join_through: "students_subjects"

    timestamps()
  end

end
