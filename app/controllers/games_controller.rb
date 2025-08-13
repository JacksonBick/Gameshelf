class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]

  # GET /games
  def index
    games = Game.all

    if params[:q].present?
      q = ActiveRecord::Base.sanitize_sql_like(params[:q].to_s.downcase)
      games = games.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?", "%#{q}%", "%#{q}%")
    end

    if params[:platform].present?
      games = games.where(platform: params[:platform])
    end

    if params[:status].present?
      games = games.where(status: params[:status])
    end

    allowed_sorts = %w[created_at release_date rating title]
    sort = params[:sort].to_s
    direction = params[:direction].to_s.downcase == "asc" ? "asc" : "desc"
    if allowed_sorts.include?(sort)
      games = games.order(Arel.sql("#{sort} #{direction}"))
    else
      games = games.order(created_at: :desc)
    end

    page = params[:page].to_i
    page = 1 if page <= 0
    per_page = params[:per_page].to_i
    per_page = 20 if per_page <= 0
    per_page = 100 if per_page > 100

    total_count = games.count
    games = games.offset((page - 1) * per_page).limit(per_page)

    response.set_header("X-Total-Count", total_count)
    response.set_header("X-Page", page)
    response.set_header("X-Per-Page", per_page)

    render json: games
  end

  # GET /games/1
  def show
    render json: @game
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:title, :platform, :status, :release_date, :rating, :description, :cover_url)
    end
end
