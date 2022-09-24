class Category < ActiveRecord::Base
   has_many :blogs

   def self.unique_categories
     self.all.uniq {|c| [c.name]}
   end
end