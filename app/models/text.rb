class Text < ActiveRecord::Base
  attr_accessible :title, :text, :section_title, :section_order

  def Text.mission_statement_sections
    Text.where(:section_title => "Mission Statement").order(:section_order)
  end
end
