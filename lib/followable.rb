module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followedships, class_name: "Followship", as: :followable)
    model_class.class_eval <<-EOF
      def followers
        self.followedships.map(&:user)
      end

      def followed_by?(user)
        self.followedships.where(user_id: user.id).exists?
      end
    EOF
    unless User.instance_methods.include?(:follow)
      User.class_eval <<-EOF
        def follow(model)
          self.followships.create(followable: model) unless followed?(model)
        end

        def followed?(model)
          self.followships.where(followable_type: model.class.to_s, followable_id: model.id).exists?
        end
      EOF
    end
    User.class_eval <<-EOF
      def followed_#{model_class.to_s.downcase.pluralize}
        self.followships.where(followable_type: #{model_class}.to_s).map(&:followable)
      end
    EOF
  end
end
