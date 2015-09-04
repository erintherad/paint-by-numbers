class User < ActiveRecord::Base
	has_secure_password

	has_many :paintings, dependent: :destroy

	validates :email, :presence => true, uniqueness: true
  validates :password_digest, :presence => true, confirmation: true

  has_attached_file :avatar,
                    :styles => { :medium => "200x200#" },
                    :storage => :s3,
                    :s3_credentials => Proc.new { |a| a.instance.s3_credentials },
                    :s3_host_name => 's3-us-west-1.amazonaws.com',
                    :path => "avatar/:id/:style/avatar.:extension",
                    :default_url => "/default-profile.png"


  def s3_credentials
   { :bucket => ENV["S3_BUCKET"], :access_key_id => ENV["S3_PUBLIC_KEY"], :secret_access_key => ENV["S3_SECRET"] }
  end

  validates_attachment :avatar,
                       :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
                       :size => { :in => 0..10000.kilobytes }
end
