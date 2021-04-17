class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type, null: false
      t.string :status, null: false, default: 'pending'
      t.string :uid, null: false
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
