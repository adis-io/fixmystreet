  module Subdomains
    def self.included( controller )
      controller.helper_method(:city_domain, :city_subdomain, :city_url, :current_city, :default_city_subdomain, :default_city_url)
    end

    protected

      # TODO: need to handle www as well
      def default_city_subdomain
        ''
      end

      def city_url( city_subdomain = default_city_subdomain, use_ssl = request.ssl? )
        http_protocol(use_ssl) + city_host(city_subdomain)
      end

      def city_host( subdomain )
        city_host = ''
        city_host << subdomain + '.'
        city_host << city_domain
      end

      def city_domain
        city_domain = ''
        city_domain << request.domain + request.port_string
      end

      def city_subdomain
        request.subdomains.first || ''
      end

      def default_city_url( use_ssl = request.ssl? )
        http_protocol(use_ssl) + city_domain
      end

      def current_city
        City.find_by_subdomain(city_subdomain)
      end

      def http_protocol( use_ssl = request.ssl? )
        (use_ssl ? "https://" : "http://")
      end
  end
