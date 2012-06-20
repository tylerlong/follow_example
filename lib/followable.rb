module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followedships, class_name: "Followship", as: :followable)
    model_class.class_eval <<-EOF
      def followers
        User.joins(:followships).where(followships: { followable_type: "#{model_class.to_s}", followable_id: self.id })
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

        def unfollow(model)
          followship = followship(model)
          followship.destroy if followship
        end

        def followed?(model)
          self.followships.where(followable_type: model.class.to_s, followable_id: model.id).exists?
        end

        def followship(model)
          self.followships.where(followable_type: model.class.to_s, followable_id: model.id).first
        end
      EOF
    end
    User.class_eval <<-EOF
      def followed_#{model_class.to_s.downcase.pluralize}
        #{model_class.to_s}.joins(:followedships).where(followships: { user_id: self.id })
      end
    EOF
  end
end
