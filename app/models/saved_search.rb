
class SavedSearch < ActiveRecord::Base
  belongs_to :user

  acts_as_favouritable

  #generates the title, for the Favourite tooltip for example.
  def title
    if (include_external_search)
      "Search: '#{search_query}' (#{search_type} - including external sites)"
    else
      "Search: '#{search_query}' (#{search_type})"
    end
  end
end
