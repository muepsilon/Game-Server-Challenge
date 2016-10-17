class Api::GamesController < ApplicationController

  def new
    size = (/^\d+$/.match(params_new[:size])).to_s.to_i
    if size == 0
      response,status = {:msg => "Invalid Grid size"},400
    else
      response,status = Api::Game.new(params_new[:nick],size),:ok
    end
    render :json => response, :status => status
  end

  def join
    response = Api::Game.join params_join
    render :json => response, :status => :ok
  end

  def start
    response = Api::Game.start params_start
    render :json => response, :status => :ok
  end

  def info
    response = Api::Game.info params_info
    render :json => response, :status => :ok
  end

  def play
    response = Api::Grid.verify_word params_play
    render :json => response, :status => :ok
  end

  def fetchall
    response = Api::Game.fetchall
    render :json => response, :status => :ok  
  end

  private

  def params_new
    params.permit(:nick,:size)
  end

  def params_join
    params.require(:game_id)
    params.permit(:game_id,:nick)
  end

  def params_start
    params.require(:game_id)
    params.permit(:game_id,:player_id)
  end

  def params_info
    params.require(:game_id)
    params.permit(:game_id,:player_id)
  end

  def params_play
    params.require(:game_id)
    params.require(:player_id)
    params.permit(:game_id,:player_id,:word)
  end
end
