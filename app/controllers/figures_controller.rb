class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])

    erb :'figures/edit'
  end

  post '/figures' do
    figure = Figure.new(params[:figure])

    if params[:title][:name] != "" && figure.titles.none? {|title| title.name == params[:title][:name]}
      figure.titles << Title.find_or_create_by(params[:title])
    end
    if params[:landmark][:name] != "" && figure.landmarks.none? {|landmark| landmark.name == params[:landmark][:name]}
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end

    figure.save

    redirect "/figures/#{figure.id}"
  end

  patch '/figures/:id' do
    figure = Figure.find_by(id: params[:id])

    figure.update(params[:figure])

    if params[:title][:name] != "" && figure.titles.none? {|title| title.name == params[:title][:name]}
      figure.titles << Title.find_or_create_by(params[:title])
    end
    if params[:landmark][:name] != "" && figure.landmarks.none? {|landmark| landmark.name == params[:landmark][:name]}
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end

    figure.save

    redirect "/figures/#{figure.id}"
  end

end
