class Status < ActiveRecord::Base
  has_many :improvement

  def get_class
    xyz = {"Initialized" => "danger", "In Progress" => "info", "Finished" => "success"}
    xyz[self.name]
  end

end
