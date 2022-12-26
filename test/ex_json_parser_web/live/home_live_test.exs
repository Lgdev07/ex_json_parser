defmodule ExJsonParserWeb.HomeLiveTest do
  use ExJsonParserWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "testing the json to elixir map submit" do
    test "should transform to elixir map because json is right", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok": "test"})}) =~
               ~s(%{&amp;quot;ok&amp;quot; =&amp;gt; &amp;quot;test&amp;quot;})
    end

    test "should not have an Error because json is right", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      refute view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok": "test"})}) =~ "Error"
    end

    test "should return an error because json is wrong", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok" "test"})}) =~ "Error"
    end
  end

  describe "testing the elixir map to json submit" do
    test "should transform to elixir map because json is right", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok": "test"})}) =~
               ~s(%{&amp;quot;ok&amp;quot; =&amp;gt; &amp;quot;test&amp;quot;})
    end

    test "should not have an Error because json is right", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      refute view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok": "test"})}) =~ "Error"
    end

    test "should return an error because json is wrong", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view
             |> element("form")
             |> render_submit(%{"json" => ~s({"ok" "test"})}) =~ "Error"
    end
  end
end
