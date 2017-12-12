class Section < ActiveRecord::Base

	has_many :section_edits
	belongs_to :page
	has_many :admin_users, :through => :section_edits
	acts_as_list  :scope => :page
	after_save :touch_page
	CONTENT_TYPE = ['text','HTML']
	validates :name, presence: true
	validates :name, length: { minimum: 10 }
	validates :content, presence: true
	 validates :content_type, inclusion: { in: CONTENT_TYPE ,
    message: "must be one of :#{CONTENT_TYPE.join(',')}" }
	scope :visible, lambda { where(:visible => true) }
    scope :invisible, lambda { where(:visible => false) }
    scope :sorted, lambda { order("subjects.position ASC") }
    scope :newest_first, lambda { order("subjects.created_at DESC")}

  private
  def touch_page
  page.touch
  end

end
