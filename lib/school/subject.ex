defmodule School.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :name, :string

    many_to_many :students, School.Student, join_through: "students_subjects"

    timestamps()
  end

  def changeset(subject, params \\ %{}) do
    subject
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 5)
  end
end
