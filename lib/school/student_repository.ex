defmodule School.StudentRepository do
  alias School.Student
  alias School.Subject
  alias School.Repo
  alias School.StudentRepository

  import Ecto.Query

  def create_new_student(params \\ %{}) do
    student = Student.changeset(%Student{}, params)
    |> Repo.insert()

    case student do
      {:ok, student} -> student
      {:error, changeset} -> Student.show_errors_by_changeset(changeset)
    end
  end

  def get_student_by_id(id) do
    query = from(s in Student, select: %{id: s.id, name: s.name, age: s.age}, where: s.id == ^id)

    case Repo.one(query) do
      nil -> "Student not found"
      student -> student
    end
  end

  def get_all_students do
    query = from(s in Student, select: %{id: s.id, name: s.name, age: s.age})
    Repo.all(query)
  end

  def delete_student_by_id(id) do
    case Repo.get(Student, id) do
      nil -> "Student not found"
      student -> Repo.delete(student)
    end
  end

  def update_student(id, new_params) do
    student = Repo.get(Student, id)

    update_flow = case student do
      nil -> "Student not found"
      student ->
        Student.changeset_update(student, new_params)
        |> Repo.update()
      end

    case update_flow do
      {:ok, student} -> student
      {:error, changeset} -> Student.show_errors_by_changeset(changeset)
      _ -> "Student not found"
    end
  end

  defp update_subject_by_student_changeset_valid(subject, student) when not is_nil(subject) and student.valid? do
    subject
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:students, [student | subject.students])
      |> Repo.update()
  end

  defp update_subject_by_student_changeset_valid(_subject, _student) do
    {:error, "Subject not found or student is invalid"}
  end
  def create_student_by_subject_existed(subject_id, params) do
    subject = Subject |> Repo.get(subject_id) |> Repo.preload(:students)

    student = Student.changeset(%Student{}, params)

    subject
      |> update_subject_by_student_changeset_valid(student)
  end
end
