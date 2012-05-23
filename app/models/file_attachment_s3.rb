class FileAttachmentS3 < ActiveRecord::Base
  attr_accessible :item_id

  belongs_to :item

  def self.s3_config
    @@s3_config ||= YAML.load(ERB.new(File.read("#{Rails.root}/config/s3.yml")).result)[Rails.env]
  end


  has_attached_file :data, :storage => :aws, 
		    :s3_credentials => {
                      :access_key_id => self.s3_config['access_key_id'],
                      :secret_access_key => self.s3_config['secret_access_key'],
                      :endpoint => self.s3_config['endpoint']
                    },
                    :s3_bucket => self.s3_config['bucket'],                    
                    :s3_host_alias => self.s3_config['s3_host_alias'],
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
