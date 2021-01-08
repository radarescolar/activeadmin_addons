module ActiveadminAddons
  module Generators
    class AssetsGenerator < Rails::Generators::Base
      class_option :theme, type: :string, default: '', desc: "Use default or 'material' theme"

      def add_javascripts
        file_path = 'app/assets/javascripts/active_admin'
        reference = "#= require active_admin/base\n"

        begin
          inject_into_file("#{file_path}.js.coffee", coffee_assets, after: reference)
        rescue
          reference = "//= require active_admin/base\n"
          inject_into_file("#{file_path}.js", js_assets, after: reference)
        end
      end

      def add_stylesheets
        file_path = 'app/assets/stylesheets/active_admin'

        begin
          prepend_file("#{file_path}.scss", css_assets)
        rescue
          prepend_file("#{file_path}.css.scss", css_assets)
        end
      end

      private

      def js_assets
        to_add = "//= require activeadmin_addons/all\n"
        to_add
      end

      def coffee_assets
        to_add = "#= require activeadmin_addons/all\n"
        to_add
      end

      def css_assets
        "@import 'activeadmin_addons/all';\n"
      end
    end
  end
end
