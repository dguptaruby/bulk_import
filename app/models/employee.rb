class Employee < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :policies

  validates :name, presence: true
  validates :email, uniqueness: true

  acts_as_nested_set

  def self.csv_generate(file, company)
    employees = []
    employees_polices = []
    CSV.foreach(file.path, headers: true) do |row|
      employee, polices = Employee.employee_obj(row.to_h, company)
      employees << employee if employee.present?
      employees_polices << polices
    end
    Employee.import employees, validate: true
    AssignPoliciesJob.perform_now(employees, employees_polices, company.id)
    employees
  end

  def self.employee_obj(row,company)
    employ_params = {}
    employ_params[:name] = row["Employee Name"]
    employ_params[:email] = row["Email"]
    employ_params[:phone] = row["Phone"]
    employ_params[:report_to] = row["Report To"]
    employee = company.employees.build(employ_params)
    polices = employee.policy_data(row) if employee.valid?
    return [employee, polices ] if employee.valid?
  end

  def policy_data(row)
    policies = []
    row_policies = row["Assigned Policies"].split('|')
  end
end
