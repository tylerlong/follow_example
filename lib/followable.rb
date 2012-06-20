module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followships, as: :followable)
    model_class.class_eval <<-EOF
      def followers
        self.followships.map(&:user)
      end
    EOF
    unless User.instance_methods.include?(:follow)
      User.class_eval <<-EOF
        def follow(model)
          self.followships.create(followable: model)
        end
      EOF
    end
    User.class_eval <<-EOF
      def followed_#{model_class.to_s.downcase.pluralize}
        self.followships.map(&:followable).select{ |item| item.class==#{model_class.to_s} }
      end
    EOF
  end
end
