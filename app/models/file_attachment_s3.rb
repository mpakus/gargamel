class FileAttachmentS3 < ActiveRecord::Base
  attr_accessible :item_id

  belongs_to :item

  has_attached_file :data, :storage => :aws, 
		    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                      :endpoint => "https://s3-eu-west-1.amazonaws.com
"
                    },
                    :s3_bucket => "eshopfiles",                    
                   #:s3_host_alias => self.s3_config['s3_host_alias'],
		    :s3_permissions => :public_read,
                    :s3_protocol => 'http',
                    :s3_options => {
                      :server_side_encryption => 'AES256',
                      :storage_class => :reduced_redundancy,
                      :content_disposition => 'attachment'
                    },

                    :path => "files/:id/:data_file_name"  
  before_save do
    self.data.s3_options[:content_disposition] = "attachment; filename=#{self.data_file_name}"
    self.data.s3_options[:server_side_encryption] = true if self.confidential_information?
    self.data.s3_options[:storage_class] = true if self.unimportant_information?

    self.data.s3_protocol = 'https' if self.confidential_information?

    self.data.s3_permissions = :authenticated_read if self.private?
  end      

end
