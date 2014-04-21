# app/policies/post_policy.rb

class PostPolicy < ApplicationPolicy

  def destroy?
    user.present? && (record.user == user || user.role?(:admin) || user.role?(:moderator))
  end
end

