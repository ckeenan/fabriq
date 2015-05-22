class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :fromuser
      t.string :touser
    end
  end
end
