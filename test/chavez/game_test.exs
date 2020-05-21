defmodule Chavez.GameTest do
  use Chavez.DataCase

  alias Chavez.Game

  describe "scores" do
    alias Chavez.Game.Score

    @valid_attrs %{name: "some name", score: 42, time: 42, tries: 42}
    @update_attrs %{name: "some updated name", score: 43, time: 43, tries: 43}
    @invalid_attrs %{name: nil, score: nil, time: nil, tries: nil}

    def score_fixture(attrs \\ %{}) do
      {:ok, score} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_score()

      score
    end

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Game.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Game.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      assert {:ok, %Score{} = score} = Game.create_score(@valid_attrs)
      assert score.name == "some name"
      assert score.score == 42
      assert score.time == 42
      assert score.tries == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      assert {:ok, %Score{} = score} = Game.update_score(score, @update_attrs)
      assert score.name == "some updated name"
      assert score.score == 43
      assert score.time == 43
      assert score.tries == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_score(score, @invalid_attrs)
      assert score == Game.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Game.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Game.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Game.change_score(score)
    end
  end

  describe "scores" do
    alias Chavez.Game.Score

    @valid_attrs %{name: "some name", time: 42, tries: 42}
    @update_attrs %{name: "some updated name", time: 43, tries: 43}
    @invalid_attrs %{name: nil, time: nil, tries: nil}

    def score_fixture(attrs \\ %{}) do
      {:ok, score} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_score()

      score
    end

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Game.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Game.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      assert {:ok, %Score{} = score} = Game.create_score(@valid_attrs)
      assert score.name == "some name"
      assert score.time == 42
      assert score.tries == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      assert {:ok, %Score{} = score} = Game.update_score(score, @update_attrs)
      assert score.name == "some updated name"
      assert score.time == 43
      assert score.tries == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_score(score, @invalid_attrs)
      assert score == Game.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Game.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Game.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Game.change_score(score)
    end
  end
end
