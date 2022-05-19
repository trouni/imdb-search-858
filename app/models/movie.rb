class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  multisearchable against: [:title, :synopsis]

  pg_search_scope :global_search,
                  against: [:title, :synopsis],
                  associated_against: { director: [:first_name, :last_name] },
                  using: { tsearch: { prefix: true } }
end
