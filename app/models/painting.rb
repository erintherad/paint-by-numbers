class Painting < ActiveRecord::Base

	belongs_to :user

	has_many :favorites, dependent: :destroy
	
	has_many :users, through: :favorites

	has_attached_file :url,
										:styles => { :medium => "500x500#" },
										:storage => :s3,
										:s3_credentials => Proc.new { |a| a.instance.s3_credentials },
										:s3_host_name => 's3-us-west-1.amazonaws.com',
										:path => "paintings/:id/:style/url.:extension",
										:default_url => "/default-profile.png"

	def s3_credentials
		{ :bucket => ENV["S3_BUCKET"], :access_key_id => ENV["S3_PUBLIC_KEY"], :secret_access_key => ENV["S3_SECRET"] }
	end

	validates_attachment :url,
											 :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
											 :size => { :in => 0..10000.kilobytes }                

	
end
