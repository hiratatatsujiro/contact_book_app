class ClassCommunicationsTag
  include ActiveRecord::AttributeAssignment
  include ActiveModel::Model

  attr_accessor :class_communication_day, :title, :text, :tag_name, :images, :user_id

  with_options presence: true do
    validates :class_communication_day
    validates :title
    validates :text
    validates :images
    validates :tag_name
  end

  def save
    class_communication = ClassCommunication.create(class_communication_day: class_communication_day, title: title, text: text,
                                                    images: images, user_id: user_id)

    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    TagClassCommunication.create(class_communication_id: class_communication.id, tag_id: tag.id)
  end
end
