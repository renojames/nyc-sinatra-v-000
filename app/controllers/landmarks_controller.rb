class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :"/landmarks/new"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    if !!params["name"] && params["name"] != ""
      @landmark.name = params["landmark"]["name"]
    end

    if !!params["year_completed"] && params["year_completed"] != ""
      @landmark.year_completed = params["landmark"]["year_completed"]
    end
    binding.pry
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"

  end

end
