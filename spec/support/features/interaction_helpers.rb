module Features
  module InteractionHelpers
    def wait_to(message, seconds: 20, interval: 2, &block)
      Timeout::timeout(seconds, Timeout::Error, "Failed waiting to #{message}") do
        while block.call
          sleep interval
        end
      end
    rescue Timeout::Error => e
      byebug
    end

    def js!(code, wait: 0.1)
      page.evaluate_script(code).tap { |_| sleep wait }
    end
  end
end
