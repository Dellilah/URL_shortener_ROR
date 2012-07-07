class UrlsController < ApplicationController
  
  def new
    @url = Url.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @url }
    end
  end
  
  def shorten_url
    #create random string
    chars = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    loop{
      @short_url =(0..6).map{chars[rand(chars.length)]}.join
      @urls = Url.find(:all, :conditions => ["short_url LIKE ?", @short_url])
      break unless (@urls.length)>0
    }
    
    
    
    @url = Url.new(:long_url => params[:long_url], :short_url=> @short_url)
    
    respond_to do |format|
      if @url.save
        format.html { render "show" }
        format.json { render json: @url, status: :created, location: @url }
      else
        format.html { render action: "new" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def show
    @url = Url.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @url }
    end
  end
  
  def redirect
    @key = params[:url]
    @url = Url.find(:all, :conditions => ["short_url LIKE ?", @key])
    
    if @url.length ==0
      flash[:notice] = "No link to redirect!"
      redirect_to :action => "new"
    else
      @url[0].redirections = @url[0].redirections + 1
      @url[0].save
      redirect_to @url[0].long_url
    end
  end

  def check_stats
    @key = params[:short_url]
    @temp = @key.partition("/u/");
    @key = @temp[2];
    @url = Url.find(:all, :conditions => ["short_url LIKE ?", @key])
    if @url.length == 1
	 @url = @url[0]
    
   	 respond_to do |format|
     
      	 	 format.html { render "show" }
       	 format.json { render json: @url, status: :created, location: @url }
      
   	 end
    else
	flash[:notice] = "Link doesn't exist in data base"
       redirect_to :action => "new"
    end
	
    
  end

end
