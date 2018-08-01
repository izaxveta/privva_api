ApiPagination.configure do |config|
  config.paginator = :will_paginate
  config.page_param = :page
  config.per_page_param = :page_size

  # Optional: Include the total and last_page link header
  # By default, this is set to true
  # Note: When using kaminari, this prevents the count call to the database
  config.include_total = false
end