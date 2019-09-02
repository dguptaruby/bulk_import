class AddReportToToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column(:employees, :report_to, :string, null: true, default: 'Boss')
  end
end
