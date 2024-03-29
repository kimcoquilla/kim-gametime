require 'open-uri'
require 'json'

class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
    @review = Review.new

    if @game.name == 'English Word'
      @letters = ('A'..'Z').to_a.shuffle[0..9]
    end

    if @game.name == 'Guess the Capital City'
      @country = params[:country]
      url = "https://countriesnow.space/api/v0.1/countries/capital"
      json_string = URI.open(url).read
      result = JSON.parse(json_string)
      number = rand(0..250)
      @country = result["data"][number]
      @countname = @country["name"]
      @capital = @country["capital"]
    end

    if @game.name == 'Country Flag Game'
      @countryflag = params[:countryflag]
      url = "https://countriesnow.space/api/v0.1/countries/flag/images"
      json_string = URI.open(url).read
      result = JSON.parse(json_string)
      number = rand(1..210)
      @countryflag = result["data"][number]
      @flagname = @countryflag["name"]
      @flagimg = @countryflag["flag"]
    end
  end

  def score
    @game = Game.find_by(name: 'English Word')
    @answer = params[:answer]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    json_string = URI.open(url).read
    result = JSON.parse(json_string)
      if result["found"] && included?(@answer.upcase, @letters)
        @score = "Congratulations! #{@answer.upcase} is a valid English word"
      elsif result["found"]
        @score = "Sorry but #{@answer.upcase} can't be built out of #{@letters}"
      else
        @score = "Sorry but #{@answer.upcase} does not seem to be a valid English word"
      end
  end

  def capital
    @game = Game.find_by(name: 'Guess the Capital City')
    @cap = params[:cap]
    @countname = params[:countname]
    @capital = params[:capital]
      if @cap.upcase == @capital.upcase
        @capres = "Congratulations! #{@cap.upcase} is the capital of #{@countname.upcase}"
      else
        @capres = "Sorry please try again! Correct answer is #{@capital.upcase}"
      end
  end

  def flag
    @game = Game.find_by(name: 'Country Flag Game')
    @flag = params[:flag]
    @flagname = params[:flagname]
    @flagimg = params[:flagimg]
    if @flag.upcase == @flagname.upcase
      @flagres = "Congratulations! You are awesome 😁"
    else
      @flagres = "Sorry please try again! Correct answer is #{@flagname.upcase}"
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :description)
    end

    def included?(answer, letters)
      answer.chars.all? {|letter| answer.count(letter) <= letters.count(letter)}
    end
end
