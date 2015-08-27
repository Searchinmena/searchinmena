class BusinessItem::Photo::Params
  attr_accessor :existing_ids, :new_files

  def initialize(existing_files, new_files)
    self.existing_ids = existing_files.map { |h| h['id'] }.compact
    self.new_files = new_files
  end

  def count
    existing_ids.count + new_files.count
  end
end
