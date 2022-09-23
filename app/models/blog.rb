class Blog < ActiveRecord::Base

    has_many :comments
    belongs_to :author
    belongs_to :category
    has_many :users, through: :comments

   def self.sort_by_date
    self.order(:created_at)
   end
end