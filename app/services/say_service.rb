class SayService
  include AASM 

  attr_reader :path

  aasm do 
    state :init, initial: true  
    state :error, :ready, :talking, :waiting

    after_all_transitions :notify

    event :run, before: :locate_say do 
      error do |e|
        puts "Failed: #{e}"
      end
      transitions from: :init, to: :ready
    end

    event :talk do 
      transitions from: :ready, to: :talking
    end

    event :pause do 
      transitions from: :talking, to: :waiting
    end

    event :reset do 
      transitions from: [:init, :waiting], to: :ready
    end

  end

   def say(voice, message)
     talk 
     `#{@path} -v #{voice} #{message}`
     wait 1
     reset
   end

   def locate_say
      @path ||= `which say`.chop
      raise "Say not found ('#{@path}')" unless File.exist? @path 
      Rails.logger.info "Found say binary at '#{path}'"
   end

   def wait(time)
      pause
      sleep time 
   end

   def on_notify(&block)
     @notify_block = block  
   end

   def notify
     if @notify_block.is_a? Proc 
       @notify_block.call aasm.to_state, aasm.current_event
     end
   end

end
