class Material < ActiveRecord::Base
  
  default_scope order: 'materials.title ASC'  
  
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications

  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  has_many :images, :dependent => :destroy 
  
  has_one :material_type
    
  validates :title, presence: true
  validates_uniqueness_of :title
  
  #after_validation :reset_finishes, :only => :update #, :populte :create
  
  attr_accessible :title, :description, :material_type_id, :finish_ids, :application_ids

  
  # clear out old finishes before populating with new selections
  # def reset_finishes()
  #   self.finishes = [] 
  # end  

  
  def populate_finishes(finish_ids)
    
    return unless finish_ids.kind_of?(Array)
    
    finish_ids.each do |finish_id|
      finish = Finish.find(finish_id)
      next if finish.nil? or self.finishes.include?(finish)
      self.finishes << finish 
    end
  end
end
  
