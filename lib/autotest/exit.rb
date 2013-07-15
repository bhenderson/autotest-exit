module Autotest::Exit
  VERSION = "1.0.0"

  Exit = Class.new StandardError

  @@enabled = true
  def self.disable!
    @@enabled = false
  end

  Autotest.add_hook :all_good do
    raise Exit if @@enabled
  end

  Autotest::HOOKS[:died].unshift proc{ |_, err|
    Exit === err
  }
end
