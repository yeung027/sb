class Visitor < ActiveRecord::Base
    belongs_to :user
    validates :ip, presence: true
    validates :url, presence: true
    validates :controller, presence: true
    validates :action, presence: true
end
