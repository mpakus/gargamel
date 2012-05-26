class News < ActiveRecord::Base
  attr_accessible :content, :title
 
  opinio_subjectum

  has_many :comments, :as => :commentable
end
