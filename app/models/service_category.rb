class ServiceCategory < Category
  searchkick text_start: [:name]
end
