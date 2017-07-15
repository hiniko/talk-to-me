class SayService
  include AASM 

  aasm do 
    state :init, initial: true  
    state :error, :ready, :talking, :waiting

    after_all_transitions :notify_users

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
   end

   def say(*args)
     `say #{args[0]}`
   end

   def wait(*args)
      sleep args[0] 
   end

   def notify_users
     puts "Changing to #{aasm.to_state} via #{aasm.current_event}"
   end

end
