class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :post_id
      t.text :description

      t.timestamps null: false
    end
  end
end
