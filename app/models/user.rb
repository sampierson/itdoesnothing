class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  serialize :roles
  before_validation :set_default_roles

  ROLES = %w{ user admin developer }
  DEFAULT_ROLES = %w{ user }

  validate :validate_roles

  # Define predicate methods for each of the roles
  ROLES.each do |role|
    class_eval <<-END
      def #{role}?
        self.roles.include?("#{role}")
      end
    END
  end

  private

  def set_default_roles
    # Unfortunately ActiveRecord uses the raw default value from the database when initializing attributes,
    # which means that roles ends up as a yaml string, which is unhelpful.  So we set it to an array here,
    # which means we can now validate it is an array hereafter.
    self.roles = DEFAULT_ROLES if new_record? && roles.is_a?(String)
  end

  def validate_roles
    if roles.is_a?(Array)
      roles.each do |role|
        errors.add(:roles, "invalid role: #{role}") unless ROLES.include?(role)
      end
    else
      errors.add(:roles, "must be an array")
    end
  end
end
