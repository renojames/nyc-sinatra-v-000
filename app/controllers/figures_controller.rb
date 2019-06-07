class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do

    @figure = Figure.new(name: params["figure"]["name"])

    params["figure"]["title_ids"].each do |title_id|
      @figure.titles << Title.find(title_id.to_i)
    end

    binding.pry

  end

end
