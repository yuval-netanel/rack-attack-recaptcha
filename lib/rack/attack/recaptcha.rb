require "rack/attack"
require "rack/attack/recaptcha/version"
require "rack/attack/recaptcha/client_helper"
require "rack/attack/recaptcha/verification_helper"
require "rack/attack/recaptcha/rails"

module Rack
  class Attack
    module Recaptcha
      class << self

        def new(app)
          @rack_attack = Rack::Attack.new(app).tap { |attack|
            attack.class.throttled_response = lambda { |env|
              env["rack.attack.use_recaptcha"] = true
              app.call(env)
            }
          }

          self
        end

        def call(env)
          @rack_attack.call(env)
        end
      end
    end
  end
end
