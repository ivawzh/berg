require "berg/decorator"

module Main
  module Decorators
    class HomePagePost < Berg::Decorator

      def image_url(size="original")
        __getobj__.image_url(size)
      end

      def teaser
        __getobj__.teaser if __getobj__.respond_to? :teaser
      end

      private

      def attache_url_for(file_path, geometry)
        prefix, basename = File.split(file_path)
        [Berg::Container["config"].attache_downloads_base_url, "view", prefix, CGI.escape(geometry), CGI.escape(basename)].join('/')
      end
    end
  end
end
