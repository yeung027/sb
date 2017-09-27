class Post < ActiveRecord::Base
    enum featured_type: {
        None: "1",
        Left: "2",
        RightTop: "3",
        RightBottomLeft: "4",
        RightBottomRight: "5"
  }
    belongs_to :user
    validates :title, length: { in: 1..30 }
    has_attached_file :small_image,
                             styles: { :original => '160x160!' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
    validates_attachment :small_image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }
    
    validates :small_image, presence: true
    
    has_attached_file :featured_image,
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
    validates_attachment :featured_image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..5.megabytes }
    
    validates :featured_image, presence: true, :if => :featured?
    
    def featured?
        featured != Post.featured_types["None"]
    end
    
    
end
