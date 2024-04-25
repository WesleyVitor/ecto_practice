defmodule School.SubjectRepository do

  alias School.Subject
  alias School.Repo

  import Ecto.Query

  def create_new_stu(params \\ %{}) do
    subject = Subject.changeset(%Subject{}, params)
      |> Repo.insert()

    case subject do
      {:ok, subject} -> subject
      {:error, changeset} -> Subject.show_errors_by_changeset(changeset)
    end
  end

  def get_subject_by_id(id) do
    query = from(s in Subject, select: %{id: s.id, name: s.name}, where: s.id == ^id)

    case Repo.one(query) do
      nil -> "Subject not found"
      subject -> subject
    end
  end

  def get_all_subjects do
    query = from(s in Subject, select: %{id: s.id, name: s.name})
    Repo.all(query)
  end

  def delete_subject_by_id(id) do
    case Repo.get(Subject, id) do
      nil -> "Subject not found"
      subject -> Repo.delete(subject)
    end
  end

  def update_subject(id, new_params) do
    subject = Repo.get(Subject, id)

    update_flow = case subject do
      nil -> "Subject not found"
      subject ->
        Subject.changeset_update(subject, new_params)
        |> Repo.update()
      end

    case update_flow do
      {:ok, subject} -> subject
      {:error, changeset} -> Subject.show_errors_by_changeset(changeset)
      _ -> "Subject not found"
    end
  end
end
