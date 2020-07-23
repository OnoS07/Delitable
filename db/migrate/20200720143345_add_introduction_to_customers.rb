class AddIntroductionToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :introduction, :text
  end
end
