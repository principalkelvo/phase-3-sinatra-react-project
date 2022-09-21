class Blog < ActiveRecord::Base
    belongs_to :user
    belongs_to :author

   def self.sort_by_date
    self.order(:created_at)
   end
end