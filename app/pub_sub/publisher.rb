class Publisher

  def self.notify(event_name, payload={})
    if block_given?
      ActiveSupport::Notifications.instrument(event_name, payload) do
        yield
      end
    else
      ActiveSupport::Notifications.instrument(event_name, payload)
    end
  end
end
