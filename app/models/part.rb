class Part < ActiveRecord::Base

  has_many :expression_levels, :foreign_key => 'promoter_part_id'

  belongs_to :part_type

end
