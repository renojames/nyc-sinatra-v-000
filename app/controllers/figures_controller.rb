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

    if !!params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        @figure.titles << Title.find(title_id.to_i)
      end
    end

    if !!params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id.to_i)
      end
    end

    if !!params["title"] && params["title"] != ""
      @figure.titles << Title.create(name: params["title"])
    end

    if !!params["new_landmark"]["name"] && params["new_landmark"]["name"] != ""
      @figure.landmarks << Landmark.create(name: params["new_landmark"]["name"], year_completed: params["new_landmark"]["year_completed"])
    end

    @figure.save

  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])

    if !!params["figure"]["name"] && params["figure"]["name"] != ""
      @figure.name = params["figure"]["name"]
    end

    if !!params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        @figure.titles << Title.find(title_id.to_i)
      end
    end

    if !!params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id.to_i)
      end
    end

    if !!params["title"] && params["title"] != ""
      @figure.titles << Title.create(name: params["title"])
    end

    if !!params["new_landmark"]["name"] && params["new_landmark"]["name"] != ""
      @figure.landmarks << Landmark.create(name: params["new_landmark"]["name"], year_completed: params["new_landmark"]["year_completed"])
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end

end
