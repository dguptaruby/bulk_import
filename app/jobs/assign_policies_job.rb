class AssignPoliciesJob < ApplicationJob
  queue_as :default

  def perform(employees, policies, company_id)
    employees.each_with_index do |employee, index|
      employee = Employee.find_by(email:  employee.email)
      emp_policies = generate_policy(policies[index], company_id)
      emp_policies.each do |pol|
        EmployeePolicy.create(employee_id: employee.id, policy_id: pol.id)
      end
    end
  end

  def generate_policy(row_policies, company_id)
    policies = []
    row_policies.each do |policy|
      policies << Policy.find_or_create_by(name: policy, company_id: company_id)
    end
    policies
  end
end
