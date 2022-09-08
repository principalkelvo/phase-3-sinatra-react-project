class Blog < ActiveRecord::Base
    belongs_to :user
    belongs_to :author

    def self.author
        id= self.author_id
        author= Author.find(id)
        author
      end
end