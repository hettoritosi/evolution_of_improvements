  module ApplicationHelper
    # Returns the full title on a per-page basis.       # Documentation comment
    def full_title(page_title = '')                     # Method def, optional arg
      base_title = "Checkout Improvements Studiare"  # Variable assignment
      if page_title.empty?                              # Boolean test
        base_title                                      # Implicit return
      else
        page_title + " | " + base_title                 # String concatenation
      end
    end

    def comments(commentable)
      render partial: "comments/comments",
      locals: {comments: commentable.comments.all}
    end

    def is_admin?
      current_user.admin == true
    end

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end




  end
