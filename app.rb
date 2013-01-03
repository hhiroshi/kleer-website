# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require 'sinatra/r18n'
require 'sinatra/flash'
require 'redcarpet'
require 'json'
require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')

KEVENTER_EVENTS_URI = "http://keventer.herokuapp.com/api/events.xml"

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  enable :sessions
  @@keventer_reader = KeventerReader.new(KEVENTER_EVENTS_URI)
end

before do
  session[:locale] = 'es'
  @page_title = "Kleer - Agile Coaching & Training"
  flash.sweep 
  @markdown_renderer = Redcarpet::Markdown.new(
                            Redcarpet::Render::HTML.new(:hard_wrap => true), 
                            :autolink => true)
end

not_found do
  if request.path == "/entrenamos/introduccion-a-scrum"
    flash.now[:error] = "La información sobre el curso de '<strong>Introducción a Scrum</strong>' fue movida. Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
    erb :error404_to_calendar
  else
    erb :error404
  end
end

get '/' do
	@active_tab_index = "active"

	erb :index
end

get '/entrenamos' do
  puts "flash.next[:error].nil?:" + flash.next[:error].nil?.to_s
  
	@active_tab_entrenamos = "active"
	@page_title += " | Entrenamos"
  @unique_countries = @@keventer_reader.unique_countries()

	erb :entrenamos
end

get '/e-books' do
	@active_tab_ebooks = "active"
	@page_title += " | Publicamos"

	erb :ebooks
end

get '/acompanamos' do
  @active_tab_acompanamos = "active"
	@page_title += " | Acompañamos"

	erb :acompanamos
end

get '/entrenamos/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader.event(event_id, true)
  
  @active_tab_entrenamos = "active"
  @page_title = "Kleer - " + @event.friendly_title
  
  erb :event
end

get '/entrenamos/evento/:event_id_with_name/remote' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader.event(event_id, true)

  erb :event_remote, :layout => :layout_empty
end

get '/entrenamos/eventos/coming' do
  content_type :json
  DTHelper::to_dt_event_array_json(@@keventer_reader.coming_events(), true)
end

get '/entrenamos/eventos/country/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  DTHelper::to_dt_event_array_json(@@keventer_reader.events_by_country(country_iso_code), false)
end
