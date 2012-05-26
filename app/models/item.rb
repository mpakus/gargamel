class Item < ActiveRecord::Base
  opinio_subjectum
 attr_accessible :name, :price, :user_id, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :category_id

  belongs_to :user
  belongs_to :category

  has_many :payments

  has_many :comments, :as => :commentable

  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :user

  has_attached_file :file, :storage => :aws, 
		    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                      :endpoint => "s3-eu-west-1.amazonaws.com"
                    },
                    :s3_bucket => "eshopfiles",                    
                   #:s3_host_alias => self.s3_config['s3_host_alias'],
		    :s3_permissions => :authenticated_read,
                    :s3_protocol => 'https',
                    :s3_options => {
                      :server_side_encryption => 'AES256',
                      :storage_class => :reduced_redundancy,
                      :content_disposition => 'attachment'
                    },

                    :path => "files/:id/:filename"  
  before_save do
    self.file.s3_options[:content_disposition] = "attachment; filename=#{self.file_file_name}"
    #self.file.s3_options[:server_side_encryption] = true if self.confidential_information?
    #self.file.s3_options[:storage_class] = true if self.unimportant_information?

    #self.file.s3_protocol = 'https' if self.confidential_information?

    #self.file.s3_permissions = :authenticated_read# if self.private?
  end      
end
