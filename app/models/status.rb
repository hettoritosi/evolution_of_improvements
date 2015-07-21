class Status < ActiveRecord::Base
  has_many :improvement


  def self.get_all_status
      self.pluck(:id).uniq
  end

  def get_class
    xyz = {"Initialized" => "danger", "In Progress" => "info", "Finished" => "success"}
    xyz[self.name]
  end

end
