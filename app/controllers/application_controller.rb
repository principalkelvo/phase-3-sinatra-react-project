class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  #folder for storing images
  set :public_folder, 'app/public'
  set :image_dir, File.join(settings.public_folder, 'images')
 
  #GETS

  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end
  # get all blogs
  get "/blogs" do
    blog= Blog.all.sort_by_date
    blog.to_json(include: :author)
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

  # get all categories must be unique
  get "/categories" do
    category = Category.unique_categories
    category.to_json(include: :blogs)
  end

  # get each category by category name because category are unique
  get "/categories/:category" do
    category = Category.find_by(name: params[:category])
    category.to_json(include: { blogs: { include: :author } })
  end

  # get all comments of a blog 
  get "/comments" do
    comments= Comment.all
    comments.to_json(include: :user)
  end

  # get all users 
  get "/users" do
    users= User.all
    users.to_json(include: :comments)
  end

  #POSTS

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

    #post a comment
    post "/comments" do
      comments= Comment.create(
        comment: params[:comment],
        like: params[:like],
        view: params[:view],
        user_id: params[:user_id],
        blog_id: params[:blog_id]
      )
      comments.to_json(include: :user)
    end

    #UPDATE

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

#update comments
patch "/comments/:id" do
  comment = Comment.find(params[:id])
  comment= Comment.update(
        comment: params[:comment],
        like: params[:like],
        view: params[:view],
        user_id: params[:user_id],
        blog_id: params[:blog_id]
      )
      comment.to_json(include: :user)
    end

    # delete blog 
    delete "/blogs/:id" do
      blog = Blog.find(params[:id])
      blog.destroy
      blog.to_json
    end

    # delete comment
    delete "/comments/:id" do
      comment = Comment.find(params[:id])
      comment.destroy
      comment.to_json
    end

  
end
