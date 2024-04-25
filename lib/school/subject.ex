defmodule School.Subject do
  use Ecto.Schema
  alias Ecto.Changeset

  import Ecto.Changeset

  schema "subjects" do
    field :name, :string

    many_to_many :students, School.Student, join_through: "students_subjects"

    timestamps()
  end

  def params_validation(changeset) do
    changeset
      |> validate_length(:name, min: 5)
  end

  def changeset(subject, params \\ %{}) do
    subject
      |> cast(params, [:name])
      |> validate_required([:name])
      |> params_validation()
  end

  def changeset_update(subject, params) do
    subject
      |> cast(params, [:name])
      |> params_validation()
  end

  def show_errors_by_changeset(changeset \\ %Changeset{}) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
