class Connection1 < ActiveRecord::Base
  belongs_to :cleaners, :class_name => "Cleaner"
  belongs_to :connection1s, :class_name => "Connection1"

end
