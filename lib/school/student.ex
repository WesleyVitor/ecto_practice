defmodule School.Student do
  alias Ecto.Changeset
  use Ecto.Schema
  import Ecto.Changeset
  schema "students" do
    field :name, :string
    field :age, :integer

    many_to_many :subjects, School.Subject, join_through: "students_subjects"

    timestamps()
  end

  def params_validations(changeset) do
    changeset
    |> validate_required([:name, :age])
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_length(:name, min: 10)
  end

  def changeset(student, params \\ %{}) do
    student
      |> cast(params, [:name, :age])
      |> params_validations()
  end

  def changeset_update(student, params) do
    student
    |> change(params)
    |> params_validations()
  end

  def show_errors_by_changeset(changeset \\ %Changeset{}) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
