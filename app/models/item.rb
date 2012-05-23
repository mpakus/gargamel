class Item < ActiveRecord::Base
  attr_accessible :name, :price, :user_id

  belongs_to :user

  has_many :files, :class_name => "FileAttachmentS3"

  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :user
end
