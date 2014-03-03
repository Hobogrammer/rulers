require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/file_model"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type'=> 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        env['PATH_INFO'] = '/homes/index'
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        if controller.get_response
          st,hd,rs = controller.get_response.to_a
          [st,hd, [rs.body].flatten]
        else
          [200, {'Content-Type' => 'text/html'},[text]]
        end
      rescue Exception => e
        error = e.inspect + "\n" + e.backtrace.join("\n")
        return [500, {'Content-Type' => 'text/html'}, ['Something went wrong.' + error ]]
      end
    end
  end
end
