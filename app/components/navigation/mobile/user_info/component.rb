module Navigation
  class Mobile::UserInfo::Component < BaseComponent
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def email
      user.email
    end

    def initials
      user.email.split('@').first.split('.').map(&:first).first(2).join.upcase
    end
  end
end
