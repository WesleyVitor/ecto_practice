defmodule School.Repo.Migrations.CreateStudentsSubjects do
  use Ecto.Migration

  def change do
    create table(:students_subjects, primary_key: false) do
      add :student_id, references(:students, on_delete: :delete_all)
      add :subject_id, references(:subjects, on_delete: :delete_all)

    end

    create unique_index(:students_subjects, [:student_id, :subject_id])
  end
end
