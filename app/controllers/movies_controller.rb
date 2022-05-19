class MoviesController < ApplicationController
  # title, year, synopsis
  def index
    @movies =
      if params[:q].present?
        ## ActiveRecord implementation
        #
        # sql_query = <<-SQL
        #   movies.title @@ :q
        #   OR movies.synopsis @@ :q
        #   OR directors.first_name @@ :q
        #   OR directors.last_name @@ :q
        # SQL
        # Movie.joins(:director).where(sql_query, q: "%#{params[:q]}%")

        ## PgSearch implementation
        #
        Movie.global_search(params[:q])
      else
        Movie.all
      end

    ## If filtering further by location, add a new location input, then filter the records further with:
    # @movies = @movies.near(params[:location]) if params[:location]
  end
end
