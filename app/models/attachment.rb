class Attachment < ActiveRecord::Base
  belongs_to :product
  #validadcio nqeu haya archivo (paperclip)
  validates :file, Attachment_presence: true
  has_attached_file :file
  do_not_validates_attachment_file_type :file
end
