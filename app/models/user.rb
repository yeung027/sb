class User < ActiveRecord::Base
    validates :name, uniqueness: true, length: { in: 1..18 }
    validates :login, uniqueness: true, length: { in: 4..30 }
    validates :password, length: { in: 5..30 }
    self.per_page = 2
    
    def is_admin?
        login == "admin"
    end
    
end
