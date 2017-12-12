class Page < ActiveRecord::Base
	belongs_to :subject #, class_name: 'Subject', foreign_key: 'subject_id'
	has_many :sections
	acts_as_list  :scope => :subject
	before_validation :add_default_permalink   
	after_save :touch_subject
	validates :name, presence: true
	validates :name, length: { minimum: 10 }
    validates :permalink, presence: true
    validates :permalink, length: { minimum: 10 }
    validates :permalink, uniqueness: true
	has_and_belongs_to_many :admin_users, :join_table => "admin_users_pages" 
	scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("subjects.position ASC") }
  scope :newest_first, lambda { order("subjects.created_at DESC")}

  private

  def add_default_parmalink
  if permalink.blank?
  	seld.permalink = "#{id}-#{name.parameterize}"
  end
  end

  def touch_subject
  subject.touch
  end

end
