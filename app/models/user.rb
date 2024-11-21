class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'executor_id'
end
