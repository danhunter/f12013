require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/partial'
require 'yaml'
require 'haml'
require 'less'

autoload :Race, './race.rb'

# config 

configure :development do
  enable :logging, :dump_errors, :raise_errors
  set :show_exceptions, true
end

configure :production do
  enable :logging
  
  not_found do
    haml :not_found
  end
  
  error do
    haml :error
  end
end

configure do
  set :public_dir, 'public'
  set :views,  'views'
end

set :haml, :format => :html5

# resources

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  less :stylesheet
end

mime_type :otf, 'font/otf'
mime_type :ttf, 'font/ttf'
mime_type :eot, 'application/vnd.ms-fontobject'
mime_type :svg, 'image/svg+xml'

# routes

get '/' do
  puts "HELLO WORLD"
  @races ||= open("races.yml")
  puts @races
  haml :index
end

def open(filename)
  
  @races = Array.new
  
  filename << ".yml" if !(filename =~ /.yml/)

  if File.exist?(filename)
    data = YAML.load_file(filename)
    
    time_now = Time.now
    
    data[:races].each do |race_data|
      race = Race.new(race_data, time_now)
      @races << race if race.should_be_shown?    
    end

    @races
  end

end