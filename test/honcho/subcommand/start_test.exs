defmodule Honcho.Subcommand.StartTest do
  use Honcho.SimpleCase, async: true
  import ExUnit.CaptureIO
  alias Honcho.Subcommand.Start

  describe "run" do
    test "with :enoent" do
      capture_io(fn ->
        Start.run({:error, :enoent})
      end)
      |> assert_matches("Unable to find Procfile")
    end

    test "with :empty_procfile" do
      capture_io(fn ->
        Start.run({:error, :empty_procfile})
      end)
      |> assert_matches("Unable to start services: Procfile is empty")
    end

    test "with :duplicate_services" do
      capture_io(fn ->
        Start.run({:error, :duplicate_services})
      end)
      |> assert_matches("Duplicate services found in Procfile")
    end

    test "with :malformed_service" do
      capture_io(fn ->
        Start.run({:error, :malformed_service})
      end)
      |> assert_matches("Unable to start services: Procfile is malformed")
    end
  end
end
