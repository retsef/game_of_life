module Navigation
  class Desktop::UserInfo::Component < BaseComponent
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def initials
      user.email.split('@').first.split('.').map(&:first).first(2).join.upcase
    end
  end
end
