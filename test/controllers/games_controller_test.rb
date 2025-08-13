require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url, as: :json
    assert_response :success
  end

  test "should create game" do
    assert_difference("Game.count") do
      post games_url, params: { game: { cover_url: @game.cover_url, description: @game.description, platform: @game.platform, rating: @game.rating, release_date: @game.release_date, status: @game.status, title: @game.title } }, as: :json
    end

    assert_response :created
  end

  test "should show game" do
    get game_url(@game), as: :json
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { cover_url: @game.cover_url, description: @game.description, platform: @game.platform, rating: @game.rating, release_date: @game.release_date, status: @game.status, title: @game.title } }, as: :json
    assert_response :success
  end

  test "should destroy game" do
    assert_difference("Game.count", -1) do
      delete game_url(@game), as: :json
    end

    assert_response :no_content
  end
end
