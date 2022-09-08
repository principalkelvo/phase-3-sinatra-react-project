class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
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

  # post author 
  post "/authors/" do
  end
  # post blog
  post "/blogs" do
    blog= Blog.create(
    category: params[:category],
    title: params[:title],
    content: params[:content],
    photographer: params[:photographer],
    caption: params[:caption],
    tag: params[:tag],
    language: params[:language],
    author_id: params[:author_id],
    user_id: params[:user_id]
    )
  end
  patch "/blogs/:id" do
    blog = Blog.find(params[:id])
    blog.update(
      category: params[:category],
      title: params[:title],
      content: params[:content],
      photographer: params[:photographer],
      caption: params[:caption],
      tag: params[:tag],
      language: params[:language],
      author_id: params[:author_id],
      user_id: params[:user_id]
      )
    end

    # delete blog 
    delete "/blogs/:id" do
      blog = Blog.find(params[:id])
      blog.destroy
      blog.to_json
    end
end
