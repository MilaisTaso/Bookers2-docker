module ApplicationHelper
  def change_form_title
    if @form_title.present?
      @form_title
    else
      "New book"
    end
  end

  def change_table_title
    if @table_title.present?
      @table_title
    else
      "Books"
    end
  end

  def change_submit_text
    if @btn_text.present?
      @btn_text
    else
      @btn_text = "Create Book"
    end
  end
end
