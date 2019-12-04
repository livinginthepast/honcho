defmodule Honcho.ProcfileTest do
  use Honcho.SimpleCase, async: true

  alias Honcho.Procfile

  describe "read" do
    test "is an error with an empty procfile" do
      "test/fixtures/procfiles/empty"
      |> Procfile.read()
      |> assert_eq({:error, :empty_procfile})
    end

    test "can read a single service" do
      "test/fixtures/procfiles/single"
      |> Procfile.read()
      |> assert_eq({:ok, %{"name_of_thing" => ~w{some command to run}}})
    end

    test "can read a multiple services" do
      "test/fixtures/procfiles/multiple"
      |> Procfile.read()
      |> assert_eq(
        {:ok,
         %{
           "name_of_thing" => ~w{some command to run},
           "other_thing" => ~w{command},
           "third_thing" => ~w{command with a long string of arguments}
         }}
      )
    end

    test "is an error if a service name is duplicated" do
      "test/fixtures/procfiles/duplicate"
      |> Procfile.read()
      |> assert_eq({:error, :duplicate_services})
    end

    test "is an error if a service name does not end in a colon" do
      "test/fixtures/procfiles/malformed_service_name"
      |> Procfile.read()
      |> assert_eq({:error, :malformed_service})
    end

    test "is an error if there is no service command" do
      "test/fixtures/procfiles/empty_service_cmd"
      |> Procfile.read()
      |> assert_eq({:error, :malformed_service})
    end
  end
end