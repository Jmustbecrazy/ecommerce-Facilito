class Attachment < ActiveRecord::Base
  belongs_to :product
  #validadcio nqeu haya archivo (paperclip)
  validates :file, Attachment_presence: true
  has_attached_file :file, path: ":rails_root/archivos/:id/:style/:filename"
  do_not_validate_attachment_file_type :file
end
