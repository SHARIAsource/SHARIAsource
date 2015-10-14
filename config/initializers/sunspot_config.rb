#
# Default sunspot only returns 30 records and paginates.
# 10**10 seemed to error out so 10**9 should be large enough to always return all records.
# Smart Listing gem is handling the pagination.
#
Sunspot.config.pagination.default_per_page = 10**9
