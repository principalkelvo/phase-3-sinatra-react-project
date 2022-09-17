class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  #folder for storing images
  set :public_folder, 'app/public'
  set :image_dir, File.join(settings.public_folder, 'images')
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end
  # get all blogs
  get "/blogs" do
    blog= Blog.all
    blog.to_json
  end

  #get a blog
  get "/blogs/:id" do
    blog = Blog.find(params[:id])
    blog.to_json(include: :author)
  end

  #get authors
  get "/authors" do
    author= Author.all
    author.to_json
  end

  #get an author
  get "/authors/:id" do
    author = Author.find(params[:id])
    author.to_json(include: :blogs)
  end

  # get blogs by categories
  get "/blogs/category/:category" do
    blog = Blog.where("category = ?", params[:category])
    blog.to_json(include: :author)
  end

  # post author 
  # post "/authors/" do
  # end
  # post blog
  post "/blogs" do
    #creates image url and pushes the image to images folder
    #checks if image is uploaded 
      if params[:image]
        filename = params[:image][:filename]
        tempfile = params[:image][:tempfile]
        FileUtils.copy(tempfile, File.join(settings.image_dir, filename))
        new_image="http://localhost:9292/images/#{filename}"
        {status: "ok", url: new_image}.to_json
      
          #if there is image it posts 
        blog= Blog.create(
        category: params[:category],
        title: params[:title],
        content: params[:content],
        photographer: params[:photographer],
        caption: params[:caption],
        tag: params[:tag],
        language: params[:language],
        author_id: params[:author_id],
        user_id: params[:user_id],
        image: new_image,
        )
        blog.to_json
    else
      {status: "error", message: "no file"}
    end
  end

  patch "/blogs/:id" do
    blog = Blog.find(params[:id])
    if params[:image]
        filename = params[:image][:filename]
        tempfile = params[:image][:tempfile]
        FileUtils.copy(tempfile, File.join(settings.image_dir, filename))
        new_image="http://localhost:9292/images/#{filename}"
        {status: "ok", url: new_image}.to_json
          #if there is image it updates 
        blog= Blog.update(
        category: params[:category],
        title: params[:title],
        content: params[:content],
        photographer: params[:photographer],
        caption: params[:caption],
        tag: params[:tag],
        language: params[:language],
        author_id: params[:author_id],
        user_id: params[:user_id],
        image: new_image,
        )
        blog.to_json
    else
      {status: "error", message: "no file"}
    end
    end

    # delete blog 
    delete "/blogs/:id" do
      blog = Blog.find(params[:id])
      blog.destroy
      blog.to_json
    end
end
