require "admin/import"
require "admin/view"

module Admin
  module Views
    module Users
      class Edit < Admin::View
        include Admin::Import[
          "persistence.repositories.users",
          "users.forms.edit_form",
          "users.forms.password_form",
        ]

        configure do |config|
          config.template = "users/edit"
        end

        def locals(options = {})
          user = users[options.fetch(:id)]

          user_validation = options[:user_validation]
          pass_validation = options[:pass_validation]

          super.merge(
            user: user,
            user_form: user_form(user, user_validation),
            pass_form: pass_form(pass_validation)
          )
        end

        private

        def pass_form(validation)
          if validation
            password_form.build({}, validation.messages)
          else
            password_form.build
          end
        end

        def user_form(user, validation)
          if validation
            edit_form.build(validation, validation.messages)
          else
            edit_form.build(user)
          end
        end
      end
    end
  end
end
