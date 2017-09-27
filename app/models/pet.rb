class Pet < ActiveRecord::Base
    enum skill_range_type: {
        None: "1",
        All: "2"
  }
    has_many :rankings
    belongs_to :before_evolution_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "before_evolution"
    belongs_to :after_evolution_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "after_evolution"
    belongs_to :material_1_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "material_1"
    belongs_to :material_2_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "material_2"
    belongs_to :material_3_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "material_3"
    belongs_to :material_4_pet, :class_name => "Pet", primary_key: 'number', :foreign_key => "material_4"
    
    
    validates :name, uniqueness: true, length: { in: 1..30 }
    validates :number, uniqueness: true, numericality: { only_integer: true }
    
    #validates :star, inclusion: { in: 1..10 }, numericality: { only_integer: true }
    validates :before_evolution, numericality: { only_integer: true }, :allow_nil => true
    
    has_attached_file :profile_image,
                             styles: { :original => '108x108!' },
                             url: '/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
    validates_attachment :profile_image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..3.megabytes }
    
    #validates :profile_image, presence: true
    
    
    
    has_attached_file :circle_image,
                             styles: { :original => '91x92!' },
                             url: '/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
    validates_attachment :circle_image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..3.megabytes }
    
    #validates :circle_image, presence: true
    
    
    
    has_attached_file :right_big_image,
                             styles: { :original => '480x999>' },
                             url: '/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/uploads/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
    validates_attachment :right_big_image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..10.megabytes }
    
    #validates :right_big_image, presence: true
    
    validates :ranking_hp, inclusion: { in: 0..10 }
    validates_format_of :ranking_hp, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_attack, inclusion: { in: 0..10 }
    validates_format_of :ranking_attack, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_ability, inclusion: { in: 0..10 }
    validates_format_of :ranking_ability, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_leader_skill, inclusion: { in: 0..10 }
    validates_format_of :ranking_leader_skill, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_skill, inclusion: { in: 0..10 }
    validates_format_of :ranking_skill, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_skill_round, inclusion: { in: 0..10 }
    validates_format_of :ranking_skill_round, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_arrow, inclusion: { in: 0..10 }
    validates_format_of :ranking_arrow, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    validates :ranking_total, inclusion: { in: 0..10 }
    validates_format_of :ranking_total, :with => /^\d+\.?\d{0,1}$/, :multiline => true
    
    before_save :calculate_total_ranking
    
    
    
    def calculate_total_ranking
        sum = 0
        sum += self.ranking_hp
        sum += self.ranking_attack
        sum += self.ranking_ability
        sum += self.ranking_leader_skill
        sum += self.ranking_skill
        sum += self.ranking_skill_round
        sum += self.ranking_arrow
        
        result = sum / 7
        result = helper.number_with_precision(result, precision: 1)
        
        self.ranking_total = result
    end
    
    def calculate_ranking
        average_hp   = Ranking.where("pet_id = ?", self.id).average(:hp)
        if average_hp.nil?
            average_hp = 0
        end
        self.ranking_hp = helper.number_with_precision(average_hp, precision: 1)
        
        average_attack   = Ranking.where("pet_id = ?", self.id).average(:attack)
        if average_attack.nil?
            average_attack = 0
        end
        self.ranking_attack = helper.number_with_precision(average_attack, precision: 1)
        
        average_ability   = Ranking.where("pet_id = ?", self.id).average(:ability)
        if average_ability.nil?
            average_ability = 0
        end
        self.ranking_ability = helper.number_with_precision(average_ability, precision: 1)
        
        average_leader_skill   = Ranking.where("pet_id = ?", self.id).average(:leader_skill)
        if average_leader_skill.nil?
            average_leader_skill = 0
        end
        self.ranking_leader_skill = helper.number_with_precision(average_leader_skill, precision: 1)
        
        average_skill   = Ranking.where("pet_id = ?", self.id).average(:skill)
        if average_skill.nil?
            average_skill = 0
        end
        self.ranking_skill = helper.number_with_precision(average_skill, precision: 1)
        
        average_skill_round   = Ranking.where("pet_id = ?", self.id).average(:skill_round)
        if average_skill_round.nil?
            average_skill_round = 0
        end
        self.ranking_skill_round = helper.number_with_precision(average_skill_round, precision: 1)
        
        average_arrow   = Ranking.where("pet_id = ?", self.id).average(:arrow)
        if average_arrow.nil?
            average_arrow = 0
        end
        self.ranking_arrow = helper.number_with_precision(average_arrow, precision: 1)
        
        self.save!
    end
    
    def get_profile_image
        if profile_image.exists?
            return profile_image.url
        end
        return nil
    end

    
    private

    def helper
        @helper ||= Class.new do
        include ActionView::Helpers::NumberHelper
    end.new
  end
end
