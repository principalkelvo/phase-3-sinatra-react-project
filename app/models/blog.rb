class Blog < ActiveRecord::Base
    belongs_to :user
    belongs_to :author
    belongs_to :category

   def self.sort_by_date
    self.order(:created_at)
   end
end