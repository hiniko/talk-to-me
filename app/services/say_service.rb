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

    event :ready do 
      transitions from: [:talking, :waiting], to: :ready
    end

    event :talk do 
      transitions from: :ready, to: :talking, 
        after: Proc.new { |*args| say(*args) }
    end

    event :pause do 
      transitions from: [:ready, :talking], to: :waiting,
        after: Proc.new { |*args| wait(*args) }
    end


  end

   def locate_say
      @path ||= `which say`.chop
      raise "Say not found ('#{@path}')" unless File.exist? @path 
      Rails.logger.info "Found say binary at '#{path}'"
   end

   def say(*args)
     `say #{args[0]}`
   end

   def wait(*args)
      sleep args[0] 
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
